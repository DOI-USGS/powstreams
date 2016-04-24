#' Summarize a timeseries
#' 
#' @usage summarize_ts(var_src, site_name, version = c("rds", "tsv"), out =
#'   c("date_updated", "start_date", "end_date", "num_dates", "num_rows",
#'   "num_complete", "modal_timestep", "num_modal_timesteps"), on_local_exists =
#'   c("skip", "stop", "replace"))
#' @param var_src character vector of dataset types to summarize, or named list 
#'   of ts data.frames() with only the columns DateTime and the variable (where 
#'   list element names are var_srces).
#' @param site_name character vector of the same length as var_src specifying 
#'   the site or sites (e.g., "nwis_24309857") where each timeseries dataset 
#'   should be sought.
#' @param version character string indicating whether you want to download the 
#'   ts as a .tsv or .rds
#' @param out a list of one or more outputs to include in the summary dataframe,
#'   in addition to the var_src and site_name and id columns.
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
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