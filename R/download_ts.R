#' Download timeseries data to local file destination
#' 
#' Download a timeseries file to a user-specified (or temp file) location
#' 
#' @param site_name a valid mda.streams site (see \link{get_sites})
#' @param var_src a valid variable name for timeseries data (see 
#'   \code{dplyr::select(dplyr::filter(var_src_codes, data_type=='ts'), 
#'   var_src)})
#' @param folder string for a folder location
#' @param on_remote_missing character indicating what to do if the remote file 
#'   is missing
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
#' @return file handle (character path) for the downloaded file, or NA if the 
#'   timeseries is unavailable on ScienceBase
#'   
#' @author Alison P Appling, Corinna Gries, Jordan S Read, Luke A Winslow
#' @examples
#' \dontrun{
#' download_ts(var_src = 'doobs_nwis', site_name = 'nwis_06893300')
#' }
#' 
#' @importFrom mda.streams download_ts
#' @name download_ts
#' @rdname download_ts
#' @export
NULL