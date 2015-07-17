#' @title get site data from a powstreams site
#' @description returns data from site into R data.frame
#'   
#' @param with_timeseries NULL to return all sites, or character vector of
#'   timeseries variables
#' @param logic how to join the constraints in with_timeseries, ...: is any of 
#'   the listed parameters sufficient, or do you need all of them to be 
#'   available for a site to qualify?
#' @return a character vector of site IDs
#' @examples
#' \dontrun{
#' list_sites() # get all sites
#' 
#' # get all sites with a given type of data
#' list_sites(with_timeseries = 'wtr_nwis') 
#' 
#' # get all sites with both wtr and doobs data
#' list_sites(with_timeseries = c('wtr_nwis','doobs_nwis')) 
#' 
#' # get all sites with EITHER wtr or doobs data (or both)
#' list_sites(with_timeseries = c('wtr_nwis','doobs_nwis'), logic='any') 
#' }
#' @importFrom mda.streams list_sites get_var_src_codes
#' @export
list_sites <- function(with_timeseries=NULL, logic=c("all","any")) {
  
  mda.streams::list_sites(with_var_src=with_timeseries, logic=logic)
}