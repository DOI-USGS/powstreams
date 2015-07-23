library(leaflet)

# --- hack alert! ---- 
# sites = unitted::v(mda.streams::get_meta(types = c("basic"), out = c('site_name')))$site_name
# # do this expensive operation once
# 
# site_urls = data.frame(site_name=sites, sb_url=mda.streams::locate_site(sites, 'url', browser=FALSE))
# save(site_urls, file = "../powstreams/inst/shiny/data/site_urls.RData")
load(system.file('shiny','data','site_urls.RData',package='powstreams'))
# /--- hack alert! ---- 
server <- function(input, output, session) {
  
  pal <- leaflet::colorQuantile("YlOrRd", NULL, n = 8)
  
  points <- eventReactive(input$recalc, {
    site_data = unitted::v(mda.streams::get_meta(types = c("basic"), out = c('site_name','long_name','lat','lon',input$variable)))
    site_data = merge(site_data, site_urls)
    site_data[rowSums(is.na(site_data)) == 0,]
  }, ignoreNULL = FALSE)
  
  
  
  output$mymap <- leaflet::renderLeaflet({
    data <- points()
    leaflet::leaflet() %>%
      leaflet::addProviderTiles("CartoDB.Positron",
                       options = leaflet::providerTileOptions(noWrap = TRUE)
      ) %>%
      leaflet::addCircleMarkers(data = data, radius = 10, color=~pal(data[[input$variable]]), 
                       popup = ~paste0(long_name, '<br/>', 
                                       sprintf("<a href='%s' target=_blank>%s</a>",sb_url,site_name), '<br/> value: ',data[[input$variable]]))
  })
  
  observeEvent(input$kill,{
    stopApp()
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
