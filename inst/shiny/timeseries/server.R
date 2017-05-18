# To publish to waterdatascience.shinyapps.io/pow_timeseries, make sure the last
# installation of mda.streams, geoknife, unitted, sbtools, streamMetabolizer,
# and any other custom packages is done using devtools::install_github. Then use
# the Publish button in the RStudio editor window for this file.

noneselected <- "-- no variable selected --"
Sys.setenv(TZ='UTC')

library(shiny)
shinyServer(function(input, output, session) {
  
  # -- <dygraphs-builder> --
  buildDy <- function(i){
    ts <- downloaded(i)
    rangeSel_i <- if(is.null(input$dataset2) || input$dataset2 == noneselected) 1 else if(is.null(input$dataset3) || input$dataset3 == noneselected) 2 else 3
    if (!is.null(ts) && length(ts$data) > 0 ){
      dygraphs::dygraph(ts$data, group = "powstreams", periodicity=list(scale='minute',label='minute')) %>%
        dygraphs::dyOptions(colors = RColorBrewer::brewer.pal(max(3,length(names(ts$data))), "Dark2")) %>%
        dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
        dygraphs::dyAxis("y", label = ts$ylab) %>% 
        dyOptions(labelsUTC = TRUE) %>% 
        {if(i==rangeSel_i) dyRangeSelector(., fillColor='', strokeColor='', height=20) else .}
    }
  }
  # -- </dygraphs-builder> --
  
  # -- <cache-and-download> --
  downloaded <- function(i){
    datasets <- grep('dataset',names(input))
    datanames <- c()
    for (d in datasets){
      if (input[[names(input)[d]]] != noneselected)
        datanames <- c(datanames, input[[names(input)[d]]])
    }
    
    if (i <= length(datanames)){
      data = xts::xts(NULL, tzone='UTC')
      metadata <- mda.streams::get_var_src_codes(var_src==datanames[i], out=c('units','var_descrip','var'))
      ylab <- paste0(metadata$var_descrip, ' (',metadata$units,')')
      
      for (site in input$site){
        rdfile <- file.path(tempdir(),paste0(site,'-ts_',datanames[i],'.RData'))
        if (file.exists(rdfile)){
          message("file is cached, using local:", datanames[i])
          load(file = rdfile) # loads tsobject
        } else {
          message("downloading file:", datanames[i])
          file <- mda.streams::download_ts(
            var_src = datanames[i], site_name = site, on_local_exists = 'skip', on_remote_missing = "return_NA")
          if (is.na(file))
            tsobject <- xts::xts(NULL, tzone='UTC')
          else {
            unitt <- mda.streams::read_ts(file)
            var <- unitted::v(unitt)
            if(nrow(var) == 1) {
              var <- data.frame(dt=var[c(1,1),1], val=var[[1,2]]) %>% setNames(names(var))
              if(is.na(var[[1,1]])) {
                var[1] <- as.POSIXct(paste0(c("2006-10-01",format(Sys.Date(), "%Y-%m-%d")), " 00:00:00"), tz='UTC')
              } else {
                var[1] <- var[[1,1]] + as.difftime(i+c(-1,4), units="secs")
              }
            }
            lon <- mda.streams::get_site_coords(site, use_basedon=TRUE)$lon
            sitetime <- streamMetabolizer::convert_UTC_to_solartime(var[['DateTime']], longitude=lon, time.type='mean solar')
            tsobject <- xts::xts(var[[2]], order.by = lubridate::force_tz(sitetime, tzone='UTC'), tzone='UTC')
          }
          save(tsobject, list='tsobject', file = rdfile)
        }
        
        oldnames <- names(data)
        data <- merge(data, tsobject)
        if(length(tsobject) > 0)
          names(data) <- c(oldnames,paste0(site,' (',metadata$units,')'))
        
      }
      list(data=data, ylab=ylab, units = metadata$units, var=metadata$var)
    } else {
      NULL
    }# // else do nothing
  }
  # -- </cache-and-download> -- 
  
  # -- <render-map> -- 
  site_data <- unitted::v(mda.streams::get_meta(types = c("basic"), out = c('site_name','long_name','lat','lon')))
  output$mymap <- leaflet::renderLeaflet({
    data_used <- site_data[site_data$site_name %in% input$site, ]
    popups <- sprintf("<a href='http://waterdata.usgs.gov/usa/nwis/uv?site_no=%s target=_blank>%s</a><br/> value:sd",
                      sapply(data_used$site_name, function(x)strsplit(x,'[_]')[[1]][2]),data_used$site_name)
    leaflet::leaflet() %>%
      leaflet::addProviderTiles("CartoDB.Positron",
                                options = leaflet::providerTileOptions(noWrap = TRUE)) %>% 
      leaflet::addCircleMarkers(data = data_used, radius = 10,
                                popup = ~paste0(long_name, '<br/>', 
                                                sprintf("<a href='%s' target=_blank>%s</a>",mda.streams::locate_site(site_name, 'url', browser=FALSE), site_name)))
  })
  # -- </render-map> -- 
  
  # -- <render-ui-selections> -- 
  boxes.options <- reactive({
    if(!("site" %in% names(input)) || is.null(input$site)) {
      c()
    } else {
      unique(unlist(lapply(input$site, mda.streams::list_datasets)))
    }
  })
  output$Box1 = renderUI({
    if (is.null(input$site)) {
      return()
    } else {
      selection <- if(is.null(input$dataset1)) NA else input$dataset1
      box.options <- sort(c(boxes.options()[!(boxes.options() %in% c(input$dataset2,input$dataset3))], noneselected))
      if(!(selection %in% box.options)) selection <- noneselected
      selectInput("dataset1", label="Variables to visualize", choices=box.options, multiple=FALSE, selected=selection)
    }
  })
  output$Box2 = renderUI({
    if (is.null(input$dataset1) || input$dataset1 == noneselected) {
      return()
    } else {
      selection <- if(is.null(input$dataset2)) NA else input$dataset2
      box.options <- sort(c(boxes.options()[!(boxes.options() %in% c(input$dataset1,input$dataset3))], noneselected))
      if(!(selection %in% box.options)) selection <- noneselected
      selectInput("dataset2", label=NULL, choices=box.options, multiple=FALSE, selected=selection)
    }
  })
  output$Box3 = renderUI({
    if (is.null(input$dataset2) || input$dataset2 == noneselected) {
      return()
    } else {
      selection <- if (is.null(input$dataset3)) NA else input$dataset3
      box.options <- sort(c(boxes.options()[!(boxes.options() %in% c(input$dataset1,input$dataset2))], noneselected))
      if(!(selection %in% box.options)) selection <- noneselected
      selectInput("dataset3", label=NULL, choices=box.options, multiple=FALSE, selected=selection)
    }
  })
  # -- </render-ui-selections> -- 
  
  # -- <trigger-ui-render> -- 
  observeEvent(input$kill,{
    stopApp()
  })
  
  dy1 <- eventReactive(input$render, {
    buildDy(1)
  })
  output$dygraph1 <- renderDygraph({dy1()})
  dy2 <- eventReactive(input$render, {
    buildDy(2)
  })
  output$dygraph2 <- renderDygraph({dy2()})
  dy3 <- eventReactive(input$render, {
    buildDy(3)
  })
  output$dygraph3 <- renderDygraph({dy3()})
  # -- </trigger-ui-render> -- 
})