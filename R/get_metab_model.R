#' Load one or more metab_model objects into R
#' 
#' Uses a previously-downloaded copy of this metab_model unless (1) that 
#' download occurred in a different R session, or (2) on_local_exists-'replace'.
#' 
#' @param model_name the name of the metab_model file
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
#'   
#' @importFrom mda.streams get_metab_model
#' @name get_metab_model
#' @rdname get_metab_model
#' @export
NULL