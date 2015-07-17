#'@title upload a presentation to sciencebase
#'@param file a file path to the presentation for upload
#'@param ... additional parameters passed to \code{\link[sbtools]{session_check_reauth}}
#'@importFrom sbtools item_upload_create session_check_reauth current_session
#'@importFrom mda.streams locate_folder
#'@export
upload_presentation <- function(file, ...){
  
  session_check_reauth(...)
  
  pres_folder <- locate_folder('presentations')
  id_out <- item_upload_create(parent_id = pres_folder, file)
  url_out <- .url_from_id(id_out)
  return(url_out)
  
}