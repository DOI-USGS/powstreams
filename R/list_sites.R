#' Get a list of the sites on ScienceBase
#' 
#' The with_var_src argument optionally limits the list to those sites that 
#' contain specific timeseries variables.
#' 
#' @usage list_sites(with_var_src = NULL, logic=c("all","any"), 
#'   with_ts_version='rds', with_ts_archived=FALSE,
#'   with_ts_uploaded_after='2015-01-01', limit=10000)
#' @param with_var_src character vector of data variables (i.e., 1+ of those 
#'   listed in get_var_src_codes(out='var_src')), or a list of character vectors
#'   where list names are 'any' and/or 'all' to define a combination of logical 
#'   requirements
#' @param logic how to join the constraints in with_var_src, ...: is any of the 
#'   listed parameters sufficient, or do you need all of them to be available 
#'   for a site to qualify?
#' @param with_ts_version one or more of \code{c('tsv','rds')} to limit the 
#'   dataset extension to anything in with_ts_version (if the dataset is a ts)
#' @param with_ts_archived one or more of \code{c(TRUE,FALSE)} to limit the list
#'   to sites that have a ts that's archived, not archived, or either
#' @param with_ts_uploaded_after POSIXct, or convertible to POSIXct, giving date
#'   after which a ts must have been uploaded to count
#' @param limit integer. the maximum number of items to return
#' @return a character vector of site IDs
#' @examples 
#' \dontrun{
#' list_sites()
#' list_sites(with_var_src=c("wtr_nwis","doobs_nwis","shed_nhdplus"), logic="any")
#' list_sites(list("wtr_nwis",any=c("doobs_nwis","doobs_simModel"),
#'   any=list("disch_nwis", all=c("depth_calcDisch","stage_nwis"))), logic="all")
#' }
#' 
#' @importFrom mda.streams list_sites
#' @name list_sites
#' @rdname list_sites
#' @export
NULL