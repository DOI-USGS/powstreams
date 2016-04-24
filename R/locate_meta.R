#' Find a metadata object on ScienceBase
#' 
#' @usage locate_meta(type, format = c("id", "url"), by = c("tag", "dir",
#'   "either"), limit = 5000, browser = (format == "url"))
#' @param type the type of metadata you want
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @param limit integer. the maximum number of items to return
#' @examples 
#' \dontrun{
#' locate_meta('basic')
#' }
#' @importFrom mda.streams locate_meta
#' @name locate_meta
#' @rdname locate_meta
#' @export
NULL