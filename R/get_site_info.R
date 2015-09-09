#' Get a very basic summary of a site
#' 
#' @seealso \code{\link{get_meta}}, \code{\link{view_google_map}}
#'   
#' @param site_name the name[s] of the site[s], e.g., 'nwis_05515500'
#' @param on_missing character specifying how to treat missing sites. Use "NA"
#'   to include missing sites in the output but with NA for both lon and lat.
#'   Use "omit" to omit those sites from the output.
#' @param attach.units logical. Should units be attached?
#' @export
get_site_info <- function(site_name, on_missing=c("NA","omit"), attach.units=TRUE) {
  m <- get_meta(c('basic','climate'), out=c('site_name','long_name','lat','lon','alt','climate.TMEAN_RE','climate.PPT30YR_RE'))
  
  on_missing <- match.arg(on_missing)
  m_row <- match(site_name, m$site_name)
  if(length(na_rows <- which(is.na(m_row))) > 0) {
    missing_site_info <- paste0(" unrecognized site_name[s]: ", paste0(site_name[na_rows], collapse=", "))
    if(on_missing == "omit") {
      m_row <- m_row[!is.na(m_row)]
      site_name <- site_name[site_name %in% m$site_name]
      on_missing_info <- "omitting"
    } else {
      # already does the right thing for on_missing="NA"
      on_missing_info <- "returning NAs for"
    }
    warning(on_missing_info, missing_site_info)
  }
  m <- m[m_row,]
  m$site_name <- site_name
  
  if(!attach.units) {
    m <- v(m)
  }
  
  m
}