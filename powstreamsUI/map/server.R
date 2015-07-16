library(mda.streams)
library(unitted)
server <- function(input, output, session) {
  
  pal <- colorQuantile("YlOrRd", NULL, n = 8)
  
  points <- eventReactive(input$recalc, {
    site_data = v(get_meta(types = c("basic"), out = c("lat","lon","alt","long_name","site_name")))
    site_data[rowSums(is.na(site_data)) == 0,]
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("Stamen.TonerLite",
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addCircleMarkers(data = points(), radius = 10, color=~pal(alt), popup = ~paste0(long_name, ':', site_name, ' elevation:',alt))
  })
}
