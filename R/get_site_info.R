#' Get a very basic summary of a site
#' 
#' @seealso \code{\link{get_meta}}, \code{\link{view_google_map}}
#'   
#' @param site_name the name[s] of the site[s], e.g., 'nwis_05515500'
#' @export
get_site_info <- function(site_name) {
  m <- get_meta(c('basic','climate'), out=c('site_name','long_name','lat','lon','alt','climate.TMEAN_RE','climate.PPT30YR_RE'))
  m[match(site_name, m$site_name),]
}