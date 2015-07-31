#' Upload a publication to sciencebase
#'
#' You must be logged into ScienceBase with \code{\link{sb_login}} to use this
#' function
#' 
#' @param file a file path to the presentation for upload
#' @importFrom sbtools item_upload_create current_session
#' @importFrom mda.streams locate_folder
#' @export
upload_publication <- function(file){
  
  if(is.null(current_session())) stop("session is NULL. call sb_login() before uploading")
  
  pubs_folder <- locate_folder('publications')
  id_out <- item_upload_create(parent_id = pubs_folder, file)
  url_out <- paste0(sbtools:::pkg.env$url_item, id_out)
  return(url_out)
  
}