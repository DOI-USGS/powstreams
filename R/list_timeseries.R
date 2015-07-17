#'@title list timeseries data available for a particular site
#'@description list timeseries data available for a particular site
#'@param site a valid powstreams site (see \link{list_sites})
#'@return a character vector of timeseries names, or NULL if none exists. 
#'@seealso \code{\link{download_timeseries}}
#'@examples
#'list_timeseries(site = "nwis_50231500")
#'@importFrom mda.streams list_datasets
#' @export
list_timeseries = function(site){
  
  list_datasets(site_name = site, data_type='ts')
  
}