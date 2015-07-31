#' Find a high-level folder on ScienceBase
#' 
#' @param folder the folder to locate
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @examples 
#' \dontrun{
#' locate_folder("publications", format="url")
#' }
#' @importFrom mda.streams locate_folder
#' @name locate_folder
#' @rdname locate_folder
#' @export
NULL