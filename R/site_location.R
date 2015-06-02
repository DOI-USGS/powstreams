#'@title get site latitude and longitude 
#'@param site a valid powstreams site (see \code{\link{list_sites}})
#'
#'@importFrom dataRetrieval readNWISsite
#'@examples
#'site_location("nwis_11126000")
#'\dontrun{
#'site_location(list_sites(with_timeseries = c('doobs', 'wtr')))
#'}
#'@export
site_location <- function(site){
  nwis_site <- mda.streams:::parse_site_name(site)
  site_data <- readNWISsite(nwis_site)
  lat <- site_data$dec_lat_va
  lon <- site_data$dec_long_va
  location <- data.frame('longitude' = lon, 'latitude' = lat)
  
  if (length(site) > 1){
    location <- cbind(data.frame('site' = site_data$site_no), location)
  }
  return(location)
}