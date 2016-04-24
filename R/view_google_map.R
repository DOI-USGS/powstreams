#' Get, and by default browse to, a URL to the site location on Google Maps
#' 
#' @param view_google_map(site_names, browser = TRUE)
#' @param site_names a list of site names such as those returned from 
#'   make_site_name()
#' @param browser logical. Should the URL be opened in a browser?
#' @export
#' @examples 
#' \dontrun{
#' view_google_map("nwis_01484680", br=FALSE)
#' view_google_map(c("nwis_01467200","nwis_09327000","nwis_351111089512501"))
#' }
#' 
#' @importFrom mda.streams view_google_map
#' @name view_google_map
#' @rdname view_google_map
#' @export
NULL