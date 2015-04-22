#' High-level functions for accessing the Continental Stream Metabolism data
#' 
#' This package contains functions that make it easy for R users to use the 
#' Powell Center project data in particular. For lower-level functions specific
#' to the Powell Center project, see \pkg{mda.streams}, and for still
#' lower-level functions generic to all ScienceBase tasks, see \pkg{sbtools}.
#' 
#' 
#' \section{Logging in}
#' 
#' Use the \code{\link{authenticate_sb}} command from \pkg{sbtools} to establish
#' session credentials for working with ScienceBase.
#' 
#' 
#' \section{Navigating ScienceBase}
#' 
#' \itemize{
#' 
#' \item \code{\link{list_sites}}
#'  
#' \item \code{\link{list_timeseries}} 
#' 
#' }
#' 
#' 
#' \section{Reading data from ScienceBase}
#' 
#' \itemize{
#' 
#' \item \code{\link{site_location}} - downloads lat/long from SB into the R session
#' 
#' \item \code{\link{load_timeseries}} - downloads data from SB into the R session
#'  
#' \item \code{\link{download_timeseries}} - downloads data from SB into a file
#' 
#' \item \code{\link{download_watershed}} - downloads geospatial data from SB into a file
#' 
#' }
#' 
#' 
#' @docType package
#' @name powstreams
NULL