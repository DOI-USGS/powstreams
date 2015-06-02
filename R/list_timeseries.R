#'@title list timeseries data available for a particular site
#'@description list timeseries data available for a particular site
#'@param site a valid powstreams site (see \link{list_sites})
#'@param ... additional arguments passed to \code{\link[sbtools]{session_check_reauth}}, 
#'for example \code{username}
#'@return a character vector of timeseries names, or NULL if none exists. 
#'@seealso \code{\link{download_timeseries}}
#'@examples
#'list_timeseries(site = 'nwis_01018035')
#'@importFrom mda.streams get_ts_variables
#'@export
list_timeseries = function(site, ...){
  
	session_check_reauth(...)
  
  timeseries <- get_ts_variables(site = site, ...)
  
  return(timeseries)
}