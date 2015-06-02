#'@title upload a presentation to sciencebase
#'@param file a file path to the presentation for upload
#'@param ... additional parameters passed to \code{\link[sbtools]{session_check_reauth}}
#'@importFrom sbtools item_upload_create session_check_reauth current_session
#'@export
upload_presentation <- function(file, ...){
  
  session_check_reauth(...)
  session = current_session()
  
  pres_folder <- mda.streams:::get_presentation_id(session)
  id_out <- item_upload_create(parent_id = pres_folder, file, session)
  url_out <- .url_from_id(id_out)
  return(url_out)
  
}