#' Get metadata (site data) from ScienceBase
#' 
#' Keeps a locally cached copy to reduce the size and number of requests to SB.
#' 
#' @usage get_meta(types = list_metas(), out = "all", on_local_exists =
#'   c("skip", "replace"))
#' @param types one or more metadata types to select and merge into a single 
#'   table. see the options with list_metas(); all are returned by default.
#' @param out character vector or 'all'. if 'all', all columns from the selected
#'   types will be returned. if anything else, the selected columns will be 
#'   returned.
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
#' @return a metadata table
#' 
#' @importFrom mda.streams get_meta
#' @name get_meta
#' @rdname get_meta
#' @export
NULL
