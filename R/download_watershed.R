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
#'download_watershed(site = 'nwis_06893300')
#'}
#'@importFrom httr GET write_disk
#'@importFrom mda.streams get_watershed_WFS
#'@export
download_watershed = function(site, destination = NULL, session = NULL, ...){
  
  if (is.null(destination)){
    file_handle = file.path(tempdir(), paste0(site,'_watershed.zip'))
  } else {
    file_handle = file.path(destination, paste0(site,'_watershed.zip'))
  }
  sb_namespace = 'sb'
  WFS <- get_watershed_WFS(site, session = session)
  
  WFS_url <- strsplit(x = WFS, split = '&')[[1]][1]
  
  # can output geojson w/ '&outputFormat=application/json'
  query <- paste0(WFS_url, '&request=GetFeature','&typeName=', sb_namespace,
                  ":",site,'&outputFormat=SHAPE-ZIP')
  
  http <- GET(url = query, write_disk(file_handle, ...), session = session)
  

  return(file_handle)
}