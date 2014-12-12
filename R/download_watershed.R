#'@title download watershed shapefile
#'@description download a watershed shapefile to a user-specified location
#'@param site a valid powstreams site (see \link{list_sites})
#'@param destination string for a folder location
#'@param session a valid sciencebase session (see \code{\link{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@return file handle for downloaded file
#'@examples
#'download_watershed(site = 'nwis_01018035')
#'@exportMethod authenticate_sb
#'@import httr mda.streams
#'@export
download_watershed = function(site, destination = NULL, session = NULL){
  
  if (is.null(destination)){
    file_handle = tempfile(fileext = '.zip')
  } else {
    file_handle = paste0(destination,site,'.zip')
  }
  sb_namespace = 'sb'
  WFS <- get_watershed_WFS(site, session = session)
  
  WFS_url <- strsplit(x = WFS, split = '&')[[1]][1]
  query <- paste0(WFS_url, '&request=GetFeature','&typeName=', sb_namespace,
                  ":",site,'&outputFormat=SHAPE-ZIP')
  
  http <- GET(url = query, write_disk(file_handle), session = session)
  
  # check for success...
  
  
  return(file_handle)
}