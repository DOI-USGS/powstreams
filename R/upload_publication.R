#'@title upload a publication to sciencebase
#'@param file a file path to the presentation for upload
#'@param username valid sciencebase username (will be prompted for password)
#'@param ... additional parameters passed to \code{\link[sbtools]{authenticate_sb}}
#'@importFrom sbtools item_upload_create authenticate_sb
#'@export
upload_publication <- function(file, username, ...){
  
  session <- authenticate_sb(username, ...)
  
  pubs_folder <- mda.streams:::get_publication_id(session)
  id_out <- item_upload_create(parent_id = pubs_folder, file, session)
  url_out <- .url_from_id(id_out)
  return(url_out)
  
}