#' Find a high-level folder on ScienceBase
#' 
#' @usage locate_folder(folder = c("project", "metab_runs", "metab_models", 
#'   "sites", "sites_meta", "ts_meta", "ideas", "presentations", "proposals", 
#'   "publications"), format = c("id", "url"), by = c("tag", "dir", "either"), 
#'   limit = 5000, browser = (format == "url"))
#' @param folder the folder to locate
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @param limit integer. the maximum number of items to return
#' @examples 
#' \dontrun{
#' locate_folder("publications", format="url")
#' }
#' @importFrom mda.streams locate_folder
#' @name locate_folder
#' @rdname locate_folder
#' @export
NULL