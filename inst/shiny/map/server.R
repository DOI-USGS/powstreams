library(leaflet)

server <- function(input, output, session) {
  
  
  
  points <- reactive({
    site_data = mda.streams::get_meta(out = c('site_name','long_name','lat','lon','sciencebase_id',input$variable))
    site_units = unitted::get_units(site_data)
    site_data = unitted::v(site_data)
    list(data=site_data[rowSums(is.na(site_data)) == 0,], units=site_units)
  })
  
  
  
  output$mymap <- leaflet::renderLeaflet({
    pal <- leaflet::colorQuantile("YlOrRd", NULL, n = 7)
    data_out <- points()
    data = data_out$data
    units = data_out$units
    
    ramp = tryCatch({
      pal(data[[input$variable]])
      pal
    }, error = function(e) {
      leaflet::colorBin("YlOrRd", NULL, n = 7)
    })
    leaflet::leaflet() %>%
      leaflet::addProviderTiles("CartoDB.Positron",
                       options = leaflet::providerTileOptions(noWrap = TRUE)
      ) %>%
      leaflet::addCircleMarkers(data = data, radius = 10, color=~ramp(data[[input$variable]]),
                       popup = ~paste0(long_name, '<br/>', 
                                      sprintf("<a href='%s' target=_blank>%s</a>",sciencebase_id,site_name), '<br/> value: ',data[[input$variable]],' (',units[[input$variable]],')'))
  })
  
  observeEvent(input$kill,{
    stopApp()
  })
  
  output$histogram <- renderPlot({
    data_out <- points()
    data = data_out$data
    units = data_out$units
    # Render a barplot
    hist(data[[input$variable]], breaks = 20,
            ylab="Number",
            xlab=input$variable,
         main = input$variable)
  })
}
