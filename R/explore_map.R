#' explore powstreams site metadata on a map
#' 
#' open an interactive map for site data
#' 
#' @param browse use browser for map rendering
#' @export
#' @importFrom shiny runApp
#' @importFrom leaflet leaflet
explore_map <- function(browse=TRUE){
  runApp(system.file('shiny','map',package='powstreams'), launch.browser = browse)
}