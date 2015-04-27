#'@title list timeseries data available for a particular site
#'@description list timeseries data available for a particular site
#'@param site a valid powstreams site (see \link{list_sites})
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return a character vector of timeseries names, or NULL if none exists. 
#'@seealso \code{\link{download_timeseries}}
#'@examples
#'list_timeseries(site = 'nwis_01018035')
#'@importFrom mda.streams get_ts_variables
#'@export
list_timeseries = function(site, session = NULL){
  
  
  timeseries <- get_ts_variables(site = site, session = session)
  
  return(timeseries)
}