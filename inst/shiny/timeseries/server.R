
noneselected = "-- no variable selected --"

library(shiny)
shinyServer(function(input, output, session) {
  
  
  # -- <dygraphs-builder> --
  buildDy <- function(i){
    ts <- downloaded(i)
    if (!is.null(ts) && length(ts$data) > 0 ){
      dygraphs::dygraph(ts$data, group = "powstreams") %>%
        dygraphs::dyOptions(colors = RColorBrewer::brewer.pal(max(3,length(names(ts$data))), "Dark2")) %>%
        dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
        dygraphs::dyAxis("y", label = ts$ylab)
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
      data = xts::xts(NULL)
      metadata <- mda.streams::get_var_src_codes(var_src==datanames[i], out=c('units','var_descrip','var'))
      ylab <- paste0(metadata$var_descrip, ' (',metadata$units,')')
      
      for (site in input$site){
        rdfile <- file.path(tempdir(),paste0(site,'-ts_',datanames[i],'.RData'))
        if (file.exists(rdfile)){
          message("file is cached, using local:", datanames[i])
          load(file = rdfile) # loads tsobject
        } else {
          message("downloading file:", datanames[i])
          file <- mda.streams::download_ts(var_src = datanames[i], site_name = site, 
                                           on_local_exists = 'skip', on_remote_missing = "return_NA")
          if (is.na(file))
            tsobject <- xts::xts(NULL)
          else {
            unitt <- mda.streams::read_ts(file)
            var <- unitted::v(unitt)
            tsobject <- xts::xts(var[[2]], order.by = as.POSIXct(var[['DateTime']]), tz='UTC')
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
  
  site_data = unitted::v(mda.streams::get_meta(types = c("basic"), out = c('site_name','long_name','lat','lon')))
  
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
  
  # -- <render-ui-selections> -- 
  output$Box1 = renderUI(
    if (is.null(input$site)){
      return()
    } else {
      all.datasets = unique(unlist(lapply(input$site,mda.streams::list_datasets)))
      selectizeInput("dataset1","Variables to visualize",
                     c(all.datasets, noneselected),
                     multiple = FALSE, selected=noneselected)
    }
  )
  
  output$Box2 = renderUI(
    if (is.null(input$dataset1) || input$dataset1 == noneselected){
        return()
    } else {
      all.datasets = unique(unlist(lapply(input$site,mda.streams::list_datasets)))
      selectInput("dataset2", label=NULL,
                       c(all.datasets[-which(all.datasets %in% input$dataset1)],noneselected),
                       multiple = FALSE, selected=noneselected)
    }
  )
  
  output$Box3 = renderUI(
    if (is.null(input$dataset2) || input$dataset2 == noneselected){
        return()
    } else {
      all.datasets = unique(unlist(lapply(input$site,mda.streams::list_datasets)))
      selectInput("dataset3", label=NULL,
                  c(all.datasets[-which(all.datasets %in% c(input$dataset1,input$dataset2))],noneselected),
                  multiple = FALSE, selected=noneselected)
    }
  )
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