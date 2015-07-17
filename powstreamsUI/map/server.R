library(mda.streams)
library(unitted)
server <- function(input, output, session) {
  
  pal <- colorQuantile("YlOrRd", NULL, n = 8)
  
  points <- eventReactive(input$recalc, {
    site_data = v(get_meta(types = c("basic"), out = c("lat","lon","alt","long_name","site_name")))
    site_data[rowSums(is.na(site_data)) == 0,]
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    data <- points()
    leaflet() %>%
      addProviderTiles("Stamen.TonerLite",
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addCircleMarkers(data = data, radius = 10, color=~pal(alt), 
                       popup = ~paste0(long_name, '<br/>', sprintf("<a href='http://waterdata.usgs.gov/usa/nwis/uv?site_no=%s'>%s</a>",sapply(site_name, function(x)strsplit(x,'[_]')[[1]][2]), site_name), '<br/> elevation:',alt))
  })
}
