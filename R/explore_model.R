#' Explore powstreams metabolism models with graphs
#' 
#' Open interactive graphs for metabolism models
#' 
#' @param browse use browser for graph rendering
#' @export
#' @importFrom shiny runApp
#' @importFrom sbtools current_session
#' @import dygraphs unitted xts
explore_model <- function(browse=TRUE){
  if(!sbtools::is_logged_in()) login_sb()
  runApp(system.file('shiny','model',package='powstreams'), launch.browser = browse)
}