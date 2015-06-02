#' @title get site latitude and longitude
#' @param site a valid powstreams site (see \code{\link{list_sites}})
#'   
#' @importFrom mda.streams find_site_coords
#' @importFrom dataRetrieval readNWISsite
#' @examples
#' \dontrun{
#' site_location("nwis_11126000")
#' site_location("nwis_08377200")
#' site_location(list_sites(with_timeseries = c('doobs', 'wtr')))
#' }
#' @export
site_location <- function(site){
  find_site_coords(site)
}