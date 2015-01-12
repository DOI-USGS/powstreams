#'@title download timeseries data to local file destination
#'@description download a timeseries file to a user-specified (or temp file) location
#'@param site a valid powstreams site (see \link{list_sites})
#'@param variable a valid variable name for timeseries data
#'@param destination string for a folder location
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return file handle for downloaded file
#'@examples
#'\dontrun{
#'download_timeseries(site = 'nwis_01018035', variable = 'doobs')
#'}
#'@import mda.streams
#'@export
download_timeseries = function(site, variable, destination = NULL, session = NULL){
  
  file_handle <- download_ts(site = site, variable = variable, destination = destination, session = session)
  
  
}