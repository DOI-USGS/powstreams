#' Find a metab_run item on ScienceBase
#' 
#' @usage locate_metab_run(title, format = c("id", "url"), by = c("tag", "dir",
#'   "either"), limit = 5000, browser = (format == "url"))
#' @param title the title of the metabolism modeling run you want. this is the 
#'   date, tag, and run strategy separated by spaces.
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @param limit integer. the maximum number of items to return
#' @examples 
#' \dontrun{
#' locate_metab_run('150714 0.0.2 local_makefile_run')
#' }
#' @importFrom mda.streams locate_metab_run
#' @name locate_metab_run
#' @rdname locate_metab_run
#' @export
NULL