#'@title load a timeseries into local R environment 
#'@description load a timeseries into local R environment. Will download timeseries into 
#'temp file, import it into R as a data.frame, and delete the temporary file. 
#'@param site a valid powstreams site (see \link{list_sites})
#'@param variable a valid variable name for timeseries data, or a vector of variable names
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return timeseries data.frame. Will be matched in time if multiple variables are used for \code{variable}
#'@examples
#'\dontrun{
#'dissolved_oxygen <- load_timeseries(site = 'nwis_01018035', variable = 'doobs')
#'}
#'@seealso \code{\link{list_timeseries}}, \code{\link{list_sites}}
#'@import mda.streams
#'@import dplyr
#'@export
load_timeseries = function(site, variable, session = NULL){
  
  # we read gzip compression directly w/ httr::GET? see ls(httr:::parsers)
  file_handle <- download_timeseries(site, variable[1], destination = NULL, session = session, overwrite = TRUE)
  
  timeseries <- read_ts(file_handle)
  
  if (length(variable) > 1){
    for (i in 2:length(variable)){
      file_handle <- download_timeseries(site, variable[i], destination = NULL, session = session, overwrite = TRUE)
      data <- read_ts(file_handle)
      timeseries <- inner_join(x = timeseries, y = data, by = 'DateTime')
    }
  }
  
  return(timeseries)
}