#' Load one or more metab_model objects into R
#' 
#' Uses a previously-downloaded copy of this metab_model unless (1) that 
#' download occurred in a different R session, or (2) on_local_exists-'replace'.
#' 
#' @usage get_metab_model(model_name, on_local_exists = "skip", version =
#'   c("modern", "original"), update_sb = TRUE)
#' @param model_name the name of the metab_model file
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
#' @param version character. which version of the model should be returned - 
#'   ('original') the original, or ('modern') one that's been updated to work 
#'   with the current streamMetabolizer version? 'modern', the default, is 
#'   recommended.
#' @param update_sb logical. May we take some time to update ScienceBase if the 
#'   most modern version isn't up there yet?
#'   
#' @importFrom mda.streams get_metab_model
#' @name get_metab_model
#' @rdname get_metab_model
#' @export
NULL