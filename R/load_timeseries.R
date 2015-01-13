#'@title load a timeseries into local R environment 
#'@description load a timeseries into local R environment. Will download timeseries into 
#'temp file, importa it into R as a data.frame, and delete the temporary file
#'@param site a valid powstreams site (see \link{list_sites})
#'@param variable a valid variable name for timeseries data
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return timeseries data.frame
#'@examples
#'\dontrun{
#'dissolved_oxygen <- load_timeseries(site = 'nwis_01018035', variable = 'doobs')
#'}
#'@import mda.streams
#'@export
load_timeseries = function(site, variable, session = NULL){
  
  # we read gzip compression directly w/ httr::GET? see ls(httr:::parsers)
  file_handle <- download_timeseries(site, variable, destination = NULL, session = session)
  
  timeseries <- read_ts(file_handle)
  
  return(timeseries)
}