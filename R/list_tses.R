#' List the timeseries data available for a particular site
#' 
#' @param site_name a valid powstreams site name (see \link{list_sites})
#' @return a character vector of timeseries names, or NULL if none exists. 
#' @seealso \code{\link{download_ts}}
#' @examples
#' list_tses(site = "nwis_50231500")
#' 
#' @importFrom mda.streams list_tses
#' @name list_tses
#' @rdname list_tses
#' @export
NULL