#' Find a timeseries item on ScienceBase
#' 
#' @usage locate_ts(var_src = "doobs_nwis", site_name = "nwis_02322688", format
#'   = c("id", "url"), by = c("tag", "dir", "either"), limit = 5000, browser =
#'   (format == "url"))
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
#' @param limit integer. the maximum number of items to return
#' @examples 
#' \dontrun{
#' locate_ts(c("doobs_nwis","baro_nldas"), "nwis_02322688")
#' locate_ts("doobs_nwis", c("nwis_01203000","nwis_01208990","nwis_01304057"))
#' locate_ts("doamp_calcDAmp", "nwis_02322688", format="url")
#' }
#' @importFrom mda.streams locate_ts
#' @name locate_ts
#' @rdname locate_ts
#' @export
NULL