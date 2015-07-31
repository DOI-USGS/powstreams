#' Find which metadata columns are numeric. 
#' 
#' Helper function for shiny apps
#' 
#' @importFrom mda.streams get_meta
#' @keywords internal
get_numeric_meta_columns <- function(){
  meta_types = get_meta()
  
  names(which(sapply(meta_types, class) == 'unitted_numeric'))
}
