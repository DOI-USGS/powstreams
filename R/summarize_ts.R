#' Summarize a timeseries
#' 
#' @param var_src character vector of dataset types to summarize.
#' @param site_name character vector of the same length as var_src specifying
#'   the site or sites (e.g., "nwis_24309857") where each timeseries dataset
#'   should be sought.
#' @param out a list of one or more outputs to include in the summary dataframe,
#'   in addition to the var_src and site_name and id columns.
#' @export
#' @examples
#' \dontrun{
#' summarize_ts(rep(c("doobs_nwis", "wtr_nwis"), each=4), 
#'   rep(c("nwis_01021050","nwis_01036390","nwis_01073389","nwis_notasite"), times=2))
#' }
#' @importFrom mda.streams summarize_ts
#' @name summarize_ts
#' @rdname summarize_ts
#' @export
NULL