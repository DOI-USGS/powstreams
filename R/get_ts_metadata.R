#' Get information about timeseries variables and sources
#' 
#' @importFrom mda.streams get_var_src_codes
#' @export
get_ts_metadata <- function() {
  get_var_src_codes(out=c('var','src','units','metab_var','var_descrip','src_descrip'))
}