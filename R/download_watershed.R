#'@title download watershed shapefile
#'@description download a watershed shapefile to a user-specified location
#'@param site a valid powstreams site (see \link{list_sites})
#'@param destination string for a folder location
#'@param session a valid sciencebase session (see \code{\link[sbtools]{authenticate_sb}}). 
#'Set \code{session = NULL} (default) for sites on sciencebase that are public.
#'@param ... additional arguments passed to \code{\link[httr]{write_disk}} (e.g., \code{overwrite = TRUE})
#'@return file handle for downloaded file
#'@examples
#'\dontrun{
#'download_watershed(site = 'nwis_01018035')
#'}
#'@import httr mda.streams sbtools
#'@export
download_watershed = function(site, destination = NULL, session = NULL, ...){
  
  if (is.null(destination)){
    file_handle = tempfile(fileext = '.zip')
  } else {
    file_handle = file.path(destination,paste0(site,'.zip'))
  }
  sb_namespace = 'sb'
  WFS <- get_watershed_WFS(site, session = session)
  
  WFS_url <- strsplit(x = WFS, split = '&')[[1]][1]
  query <- paste0(WFS_url, '&request=GetFeature','&typeName=', sb_namespace,
                  ":",site,'&outputFormat=SHAPE-ZIP')
  
  http <- GET(url = query, write_disk(file_handle, ...), session = session)
  

  return(file_handle)
}