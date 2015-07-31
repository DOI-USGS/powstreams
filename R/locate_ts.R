#' Find a timeseries item on ScienceBase
#' 
#' @param var_src the variable name, e.g., "doobs_nwis", for which you want the 
#'   timeseries
#' @param site_name the site ID, e.g. "nwis_02322688", whose folder you want to
#'   look in
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @examples 
#' \dontrun{
#' locate_ts(c("doobs","wtr","disch"), "nwis_02322688")
#' locate_ts("doobs", "nwis_02322688", format="url")
#' locate_ts("doobs", "nwis_notasite", format="url")
#' testthat::expect_error(locate_ts("notavar", "nwis_notasite"))
#' }
#' @importFrom mda.streams locate_ts
#' @name locate_ts
#' @rdname locate_ts
#' @export
NULL