
noneselected = "-- no variable selected --"

library(shiny)
shinyServer(function(input, output, session) {
  
  # -- <cache-and-download> --
  downloaded <- function(){
    files <- mda.streams::list_metab_run_files(input$model)
    file <- files$filename[grep('RData',tools::file_ext(files$filename))[1]]
    
    file <- mda.streams::download_metab_run(input$model, file, on_local_exists = 'skip')
    load(file)
    data = xts::xts(NULL)
    if (!exists('all_out')) # hack alert!!@!!!!
      all_out = metab_all
    data <- xts::xts(all_out[[2]]@fit$GPP, order.by = as.POSIXct(all_out[[2]]@fit$date), tz='UTC')
    return(list(data = data, ylab='things', units='units for this thing',var = 'GPP'))
  }
  
  
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
  
  observeEvent(input$kill,{
    stopApp()
  })
  dy1 <- eventReactive(input$render, {
    buildDy()
  })
  output$dygraph1 <- renderDygraph({dy1()})
  # -- <dygraphs-builder> --
  buildDy <- function(){
    ts <- downloaded()
    if (!is.null(ts) && length(ts$data) > 0 ){
      dygraphs::dygraph(ts$data, group = "powstreams") %>%
        dygraphs::dyOptions(colors = RColorBrewer::brewer.pal(max(3,length(names(ts$data))), "Dark2")) %>%
        dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
        dygraphs::dyAxis("y", label = ts$ylab)
    }
  }
  # -- </dygraphs-builder> --
})