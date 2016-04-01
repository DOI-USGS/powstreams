#' Search the metab_runs
#' 
#' @param metab_run_title text to search for within the entire metab_run_title
#' @param date text to search for within the date portion of the model_name
#' @param tag text to search for within the tag portion of the model_name
#' @param strategy text to search for within the strategy portion of the 
#'   model_name
#' @param metab_runs vector of metab_run_titles to search. The default is to
#'   pull this list from ScienceBase
#' @param match_case logical. should the case be matched exactly?
#' @param fixed logical. As in \code{\link{grepl}}, TRUE to require an exact
#'   match and FALSE to use regular expressions
#' @examples 
#' \dontrun{
#' search_metab_runs(strategy='PR_FIXED')
#' search_metab_runs(date='^1512', fixed=FALSE)
#' search_metab_runs(tag='(0)\\.(0)\\.(1)[2-4]', fixed=FALSE)
#' }
#' @importFrom mda.streams search_metab_runs
#' @name search_metab_runs
#' @rdname search_metab_runs
#' @export
NULL
