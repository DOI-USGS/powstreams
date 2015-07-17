#'@title download timeseries data to local file destination
#'@description download a timeseries file to a user-specified (or temp file) location
#'@param site a valid powstreams site (see \link{list_sites})
#'@param variable a valid variable name for timeseries data
#'@param destination string for a folder location
#'@param ... additional arguments passed to \code{\link[mda.streams]{download_ts}}, 
#'for example \code{on_local_exists} 
#'@return file handle for downloaded file
#'@examples
#'download_timeseries(site = "nwis_50231500", variable = 'doobs_nwis')
#'@importFrom mda.streams download_ts
#'@export
download_timeseries = function(site, variable, destination = tempdir(), ...){
  
  file_handle <- download_ts(var_src = variable, site_name=site , folder = destination, ...)
  
  return(file_handle)

}