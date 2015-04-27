#'@title upload a presentation to sciencebase
#'@param file a file path to the presentation for upload
#'@param username valid sciencebase username (will be prompted for password)
#'@importFrom sbtools item_upload_create authenticate_sb
#'@export
upload_presentation <- function(file, username){
  
  session <- authenticate_sb(username)
  
  pres_folder <- mda.streams:::get_presentation_id(session)
  id_out <- item_upload_create(parent_id = pres_folder, file, session)
  url_out <- .url_from_id(id_out)
  return(url_out)
  
}