#' helper function for shiny launch
#' @export
#' @importFrom mda.streams get_meta
#' @keywords internal
get_types <- function(){
  meta_types = get_meta()
  
  names(which(sapply(meta_types, class) == 'unitted_numeric'))
}
