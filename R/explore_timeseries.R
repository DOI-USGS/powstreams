#' explore powstreams timeseries data on graphs
#' 
#' open interactive graphs for timeseries data
#' 
#' @param browse use browser for graph rendering
#' @export
#' @importFrom shiny runApp
#' @import dygraphs unitted xts
explore_timeseries <- function(browse=TRUE){
  runApp(system.file('shiny','timeseries',package='powstreams'), launch.browser = browse)
}