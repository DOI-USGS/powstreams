#' Search information about timeseries variables and sources
#' 
#' @param var text to search for in the var column
#' @param src text to search for in the src column
#' @param var_src text to search for in the var_src column
#' @param units text to search for in the units column
#' @param metab_var text to search for in the metab_var column
#' @param var_descrip text to search for in the var_descrip column
#' @param src_descrip text to search for in the src_descrip column
#' @param ts_metadata table of ts_metadata to search
#' @param match_case logical. should the case be matched exactly?
#' @param fixed logical. As in \code{\link{grepl}}, TRUE to require an exact 
#'   match and FALSE to use regular expressions
#' @importFrom mda.streams search_var_src_codes
#' @examples
#' search_ts_metadata(units='mgO2')
#' search_ts_metadata(var='GPP|ER',fixed=FALSE)
#' search_ts_metadata(src='estBest')
#' @export
search_ts_metadata <- function(
  var=NA, src=NA, var_src=NA, units=NA, metab_var=NA, var_descrip=NA, src_descrip=NA,
  ts_metadata=get_ts_metadata(), match_case=FALSE, fixed=TRUE
) {
  search_var_src_codes(
    var=var, src=src, var_src=var_src, units=units, metab_var=metab_var, var_descrip=var_descrip, src_descrip=src_descrip,
    var_src_codes=ts_metadata, match_case=match_case, fixed=fixed)
}