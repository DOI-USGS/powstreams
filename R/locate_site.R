#' Find a site folder on ScienceBase
#' 
#' @param site_name the site ID, e.g. "nwis_02322688", whose folder you want
#' @param format character indicating whether the folder should be returned as 
#'   an ID or as a full URL
#' @param by character indicating how to search for the item: using tags ("tag",
#'   the default and recommended option), by scanning the parent directory for 
#'   the desired title ("dir"), or both in combination ("either")?
#' @param browser logical. Should the URL be opened in a browser?
#' @examples 
#' \dontrun{
#' locate_site("nwis_02322688", format="url")
#' locate_site(c("nwis_02322688", "nwis_03259813", "nwis_04024000"))
#' locate_site("nwis_notasite", format="url")
#' testthat::expect_error(locate_site("notasite", format="url"))
#' }
#' @importFrom mda.streams locate_site
#' @name locate_site
#' @rdname locate_site
#' @export
NULL