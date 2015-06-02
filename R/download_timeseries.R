#'@title download timeseries data to local file destination
#'@description download a timeseries file to a user-specified (or temp file) location
#'@param site a valid powstreams site (see \link{list_sites})
#'@param variable a valid variable name for timeseries data
#'@param destination string for a folder location
#'@param ... additional arguments passed to \code{\link[sbtools]{item_file_download}}, 
#'for example \code{overwrite_file} and \code{\link[sbtools]{session_check_reauth}}, 
#'for example \code{username}
#'@return file handle for downloaded file
#'@examples
#'\dontrun{
#'download_timeseries(site = 'nwis_01018035', variable = 'doobs')
#'}
#'@importFrom mda.streams download_ts
#'@export
download_timeseries = function(site, variable, destination = NULL, ...){
  
  file_handle <- download_ts(site = site, variable = variable, destination = destination, ...)
  
  return(file_handle)

}