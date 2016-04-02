#' Get information about timeseries variables and sources
#' 
#' @importFrom mda.streams get_var_src_codes
#' @export
get_ts_metadata <- function() {
  data_type <- '.dplyr.var'
  get_var_src_codes(data_type=='ts', out=c('var_src','var','src','units','metab_var','var_descrip','src_descrip'))
}