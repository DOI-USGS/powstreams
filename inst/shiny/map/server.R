
server <- function(input, output, session) {
  
  pal <- leaflet::colorQuantile("YlOrRd", NULL, n = 8)
  
  points <- eventReactive(input$recalc, {
    site_data = unitted::v(mda.streams::get_meta(types = c("basic"), out = c('site_name','long_name','lat','lon',input$variable)))
    site_data[rowSums(is.na(site_data)) == 0,]
  }, ignoreNULL = FALSE)
  
  
  
  output$mymap <- leaflet::renderLeaflet({
    data <- points()
    leaflet::leaflet() %>%
      leaflet::addProviderTiles("Stamen.TonerLite",
                       options = leaflet::providerTileOptions(noWrap = TRUE)
      ) %>%
      leaflet::addCircleMarkers(data = data, radius = 10, color=~pal(data[[input$variable]]), 
                       popup = ~paste0(long_name, '<br/>', 
                                       sprintf("<a href='http://waterdata.usgs.gov/usa/nwis/uv?site_no=%s'>%s</a>",sapply(site_name, function(x)strsplit(x,'[_]')[[1]][2]), site_name), '<br/> value:',data[[input$variable]]))
  })
  
  output$histogram <- renderPlot({
    data <- points()
    # Render a barplot
    hist(data[[input$variable]], breaks = 20,
            ylab="Number",
            xlab=input$variable,
         main = input$variable)
  })
}
