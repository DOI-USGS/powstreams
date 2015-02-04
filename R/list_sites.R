#'@title get site data from a powstreams site
#'@description returns data from site into R data.frame
#'
#'@param with_timeseries NULL for all sites, or a valid timeseries name
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return a character vector of powstreams sites according to user-specified parameters
#'
#'@examples
#'list_sites() # get all sites
#'\dontrun{
#'list_sites(with_timeseries = 'wtr') # get all sites with a given type of data
#'}
#'@import mda.streams
#'@import sbtools
#'@export
list_sites <- function(with_timeseries = NULL, session = NULL){
  
  if(is.null(with_timeseries)){
    
    sites <- get_sites(session = session)
    
  } else {
    types <- make_ts_variable(variable = with_timeseries)
    sites <- vector('character')
    for (k in 1:length(types)){
      sites <- append(sites, get_sites(with_child_key = types[k], session = session))
    }
    # get sites that are repeated as many times as the number of types used
    tbl_sites <- data.frame(table(sites))
    sites <- as.character(tbl_sites$sites[tbl_sites$Freq == length(types)])
  }

  return(sites)
}