#' List the available metab_model objects
#' 
#' @usage list_metab_models(text, order_by = c("date", "tag", "row", "site",
#'   "strategy", "title"))
#' @param text if specified, the query only returns metab_models whose text (or 
#'   description, if available) matches the word[s] in \code{text}. Note that 
#'   partial words are not matched -- e.g., text='nwis_0138' will not match
#'   models whose title includes 'nwis_01388000'
#' @param order_by character vector of aspects of the model names to sort on. 
#'   Options are the same as those in the \code{out} argument to 
#'   \code{\link{parse_metab_model_name}}
#' @return a character vector of titles of the metab_model .RData files posted 
#'   on SB
#'   
#' @importFrom mda.streams list_metab_models
#' @name list_metab_models
#' @rdname list_metab_models
#' @export
NULL