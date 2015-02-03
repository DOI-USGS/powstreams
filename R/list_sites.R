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
    sites <- get_sites(session)
  } else {
    types <- mda.streams:::make_ts_variable(variable = with_timeseries) # can be multiple? not yet
    ids <- data.frame()
    for (k in 1:length(types)){
      ids <- rbind(ids, query_item_identifier(scheme = "mda_streams", type = types[k], session = session, limit = 10000))
    }
    
    sites <- vector(mode = 'character', length = nrow(ids))
    for (i in 1:nrow(ids)){
      site_id <- item_get_parent(ids[i, 2], session = session)
      sites[i] <- mda.streams:::get_title(site_id, session)
    }
    
    # get sites that are repeated as many times as the number of types used
    tbl_sites <- data.frame(table(sites))
    sites <- as.character(tbl_sites$sites[tbl_sites$Freq == length(types)])
  }

  return(sites)
}