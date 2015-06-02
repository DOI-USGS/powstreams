#'@title get site data from a powstreams site
#'@description returns data from site into R data.frame
#'
#'@param with_timeseries NULL for all sites, or a valid timeseries name
#'@param ... Additional parameters supplied to \code{\link[sbtools]{session_check_reauth}}
#'@return a character vector of powstreams sites according to user-specified parameters
#'
#'@examples
#'
#'\dontrun{
#'list_sites() # get all sites
#'list_sites(with_timeseries = 'wtr') # get all sites with a given type of data
#'}
#'@importFrom mda.streams get_sites choose_sites
#'@export
list_sites <- function(with_timeseries = NULL, ...){
  
	sites = choose_sites(with_timeseries)
  return(sites)
}