#' Search the metab_models
#' 
#' @usage search_metab_models(model_name = NA, title = NA, row = NA, site = NA, 
#'   date = NA, tag = NA, strategy = NA, metab_models = list_metab_models(),
#'   match_case = FALSE, fixed = TRUE)
#' @param model_name text to search for within the entire model_name
#' @param title text to search for within the title portion of the model_name
#' @param row text to search for within the row portion of the model_name
#' @param site text to search for within the site portion of the model_name
#' @param date text to search for within the date portion of the model_name
#' @param tag text to search for within the tag portion of the model_name
#' @param strategy text to search for within the strategy portion of the 
#'   model_name
#' @param metab_models vector of model_names to search. The default is to pull 
#'   this list from ScienceBase
#' @param match_case logical. should the case be matched exactly?
#' @param fixed logical. As in \code{\link{grepl}}, TRUE to require an exact 
#'   match and FALSE to use regular expressions
#' @examples 
#' \dontrun{
#' search_metab_models(site='nwis_08062500')
#' search_metab_models('indy', row="68.", fixed=FALSE)
#' search_metab_models(strategy='NIGHT', site='411955088280601')
#' }
#' @importFrom mda.streams search_metab_models
#' @name search_metab_models
#' @rdname search_metab_models
#' @export
NULL

