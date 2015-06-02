#'@title upload a publication to sciencebase
#'@param file a file path to the presentation for upload
#'@param username valid sciencebase username (will be prompted for password)
#'@param ... additional parameters passed to \code{\link[sbtools]{session_check_reauth}}
#'@importFrom sbtools item_upload_create session_check_reauth current_session
#'@export
upload_publication <- function(file, ...){
  
  session_check_reauth(...)
  session = current_session()
  
  pubs_folder <- mda.streams:::get_publication_id(session)
  id_out <- item_upload_create(parent_id = pubs_folder, file)
  url_out <- .url_from_id(id_out)
  return(url_out)
  
}