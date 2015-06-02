#' @title load timeseries into local R environment
#' @description load timeseries into local R environment. Will download 
#'   timeseries into temp file, import it into R as a data.frame, and delete the
#'   temporary file.
#' @param site a valid powstreams site (see \code{\link{list_sites}})
#' @param variables a valid variable name for timeseries data, or a vector of 
#'   variable names
#' @param join.fun The \pkg{dplyr} function to use when successively adding the 
#'   second, third, ... variables in \code{variables}. Good options include 
#'   \code{\link{inner_join}}, \code{\link{full_join}}, and 
#'   \code{\link{left_join}}.
#' @param ... additional parameters passed to \code{\link[sbtools]{session_check_reauth}}
#' 
#' @return timeseries data.frame. Will be matched in time if multiple variables 
#'   are used for \code{variable}
#' @examples
#' \dontrun{
#' dissolved_oxygen <- load_timeseries(site = 'nwis_01018035', variable = 'doobs')
#' metab_input <- load_timeseries(site = 'nwis_01408500', variable = c('doobs','wtr'))
#' }
#' @seealso \code{\link{list_timeseries}}, \code{\link{list_sites}}
#' @importFrom dplyr inner_join
#' @importFrom mda.streams read_ts
#' @export
load_timeseries = function(site, variables, join.fun=inner_join, ...){
  	
  # we read gzip compression directly w/ httr::GET? see ls(httr:::parsers)
  file_handle <- download_timeseries(site, variables[1], destination = NULL, overwrite = TRUE, ...)
  
  timeseries <- read_ts(file_handle)
  
  if (length(variables) > 1){
    for (i in 2:length(variables)){
      file_handle <- download_timeseries(site, variables[i], destination = NULL, overwrite = TRUE, ...)
      data <- read_ts(file_handle)
      timeseries <- join.fun(x = timeseries, y = data, by = 'DateTime')
    }
  }
  
  return(timeseries)
}