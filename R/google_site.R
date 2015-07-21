#' Get a URL to the gage location on Google Maps
#' 
#' Get a URL to the gage location on Google Maps
#' 
#' @param site a valid powstreams site (see \code{\link{list_sites}})
#' @param browse open up a browser tab to map location?
#'   
#' @importFrom mda.streams find_google_map
#' @examples
#' \dontrun{
#' google_site("nwis_11126000")
#' google_site(c("nwis_01467200","nwis_09327000","nwis_351111089512501"), browse=FALSE)
#' }
#' @export
google_site <- function(site, browse=TRUE){
  find_google_map(site_names = site, browser = browse)
}