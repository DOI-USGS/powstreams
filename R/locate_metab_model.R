#' Find a metab_model item on ScienceBase
#' 
#' @usage locate_metab_model(model_name, format = c("id", "url"), by = c("tag",
#'   "dir", "either"), limit = 5000, browser = (format == "url"))
#' @param model_name the model name, e.g., "nwis_05515500-35-150729 0.1.2 
#'   compare_par_srces"
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @param limit integer. the maximum number of items to return
#' @examples 
#' \dontrun{
#' locate_metab_model("nwis_01473900-16-150730 0.0.7 MLE_for_PRK_wHarvey_and_sw", 
#'   format="url", browser=FALSE)
#' }
#' @importFrom mda.streams locate_metab_model
#' @name locate_metab_model
#' @rdname locate_metab_model
#' @export
NULL