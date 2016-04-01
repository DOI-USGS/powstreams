#' Search the sites
#' 
#' @param everything text to search for within \code{paste(site_name,
#'   long_name)}
#' @param site_name text to search for within the [short] site_name
#' @param long_name text to search for within the long_name
#' @param database text to search for within the database portion of the 
#'   site_name
#' @param sitenum text to search for within the sitenum portion of the 
#'   site_name
#' @param site_names vector of site_names to search (with long_name added). The 
#'   default is to pull this list from ScienceBase
#' @param match_case logical. should the case be matched exactly?
#' @param fixed logical. As in \code{\link{grepl}}, TRUE to require an exact
#'   match and FALSE to use regular expressions
#' @examples 
#' search_sites('indy')
#' search_sites('connecticut river')
#' search_sites('NE$|Nebr.$', match_case=TRUE, fixed=FALSE)
#' @importFrom mda.streams search_sites
#' @name search_sites
#' @rdname search_sites
#' @export
NULL
