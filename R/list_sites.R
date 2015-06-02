#' @title get site data from a powstreams site
#' @description returns data from site into R data.frame
#'   
#' @param with_timeseries NULL to return all sites, or character vector of
#'   timeseries variables (i.e., 1+ of those listed in get_ts_variables())
#' @param logic how to join the constraints in with_timeseries, ...: is any of 
#'   the listed parameters sufficient, or do you need all of them to be 
#'   available for a site to qualify?
#' @return a character vector of site IDs
#' @examples
#' list_sites() # get all sites
#' \dontrun{
#' list_sites(with_timeseries = 'wtr') # get all sites with a given type of data
#' list_sites(with_timeseries = c('wtr','doobs')) # get all sites with both wtr and doobs data
#' list_sites(with_timeseries = c('wtr','doobs'), logic='any') # get all sites with EITHER wtr or doobs data (or both)
#' }
#' @importFrom mda.streams find_sites
#' @export
list_sites <- function(with_timeseries, logic=c("all","any"), ...) {
  find_sites(with_timeseries=with_timeseries, logic=logic, ...)
}