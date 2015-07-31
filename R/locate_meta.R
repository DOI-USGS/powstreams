#' Find a metadata object on ScienceBase
#' 
#' @param type the type of metadata you want
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @examples 
#' \dontrun{
#' locate_meta('basic')
#' }
#' @importFrom mda.streams locate_meta
#' @name locate_meta
#' @rdname locate_meta
#' @export
NULL