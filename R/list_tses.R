#' List the timeseries data available for a particular site
#' 
#' @usage list_tses(site_name, with_ts_version='rds', with_ts_archived=FALSE,
#'   with_ts_uploaded_after='2015-01-01', limit=10000)
#' @param site_name a character vector of length one with a site name such as 
#'   those returned from make_site_name()
#' @param with_ts_version one or more of \code{c('tsv','rds')} to limit the 
#'   dataset extension to anything in with_ts_version (if the dataset is a ts)
#' @param with_ts_archived one or more of \code{c(TRUE,FALSE)} to limit the list
#'   to sites that have a ts that's archived, not archived, or either
#' @param with_ts_uploaded_after POSIXct, or convertible to POSIXct, giving date
#'   after which a ts must have been uploaded to count
#' @param limit integer. the maximum number of items to return
#' @return a character vector of timeseries names, or NULL if none exists
#' @seealso \code{\link[powstreams]{get_ts}} \code{\link[powstreams]{locate_ts}}
#'   \code{\link[powstreams]{list_sites}}
#' @examples
#' list_tses(site = "nwis_50231500")
#' 
#' @importFrom mda.streams list_tses
#' @name list_tses
#' @rdname list_tses
#' @export
NULL