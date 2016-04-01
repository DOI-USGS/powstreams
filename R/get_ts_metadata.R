#' Get information about timeseries variables and sources
#' 
#' @param ... a list of unnamed arguments to pass to \code{dplyr::filter_}
#' @param out a list of arguments to pass to \code{dplyr::select_}
#' @param drop logical. if the filtering & selection lead to a data.frame whose 
#'   dimensions would ordinarily be dropped using z[x,y] location, should the 
#'   dimensions be dropped?
#' @importFrom mda.streams get_var_src_codes
#' @export
get_ts_metadata <- function(..., out=c('var','src','units','metab_var','var_descrip','src_descrip'), drop=TRUE) {
  get_var_src_codes(..., out=out, drop=drop)
}