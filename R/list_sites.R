#'@title get site data from a powstreams site
#'@description returns data from site into R data.frame
#'
#'@param within_poly FALSE for all sites, or a valid polygon
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return a character vector of powstreams sites according to user-specified parameters
#'
#'@examples
#'list_sites(within_poly = FALSE) # get all sites
#'\dontrun{
#'list_sites(within_poly = poly) # get all sites within a user specific polygon (inclusive)
#'}
#'@import mda.streams
#'@import sbtools
#'@export
list_sites <- function(within_poly, session = NULL){
  
  if (class(within_poly) == 'logical'){
    if (!within_poly){
      
      sites <- get_sites(session)
    } else {
      stop(within_poly, ' is not a valid value for within_poly.')
    }
  } else {
    # assume within_poly is a spatial object
    stop('within polygon functionality not implemented')
  }
  return(sites)
}