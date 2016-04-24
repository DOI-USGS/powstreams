#' Download and read a config file from a metab run on SB
#' 
#' @usage get_config(title, config_file = grep("config",
#'   list_metab_run_files(title), value = TRUE)[1], on_local_exists = "skip")
#' @param title the metab run title. See options using \code{list_metab_runs()}
#' @param config_file the name of the config file. It's usually but not always 
#'   'config.tsv'; use \code{list_metab_run_files(title)} to check
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
#'   
#' @importFrom mda.streams get_config
#' @name get_config
#' @rdname get_config
#' @export
NULL
