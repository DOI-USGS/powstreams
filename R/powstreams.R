#' High-level functions for accessing the Continental Stream Metabolism data
#' 
#' This package contains functions that make it easy for R users to use the 
#' Powell Center project data in particular. For lower-level functions specific 
#' to the Powell Center project, see \pkg{mda.streams}, and for still 
#' lower-level functions generic to all ScienceBase tasks, see \pkg{sbtools}.
#' 
#' @section Logging in:
#'   
#'   Use the \code{\link{authenticate_sb}} command from \pkg{sbtools} to 
#'   establish session credentials for working with ScienceBase.
#'   
#'   
#' @section Navigating ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{list_sites}}
#'   
#'   \item \code{\link{list_timeseries}}
#'   
#'   }
#'   
#' @section Reading data from ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{site_location}} - downloads lat/long from SB into the R 
#'   session
#'   
#'   \item \code{\link{load_timeseries}} - downloads data from SB into the R 
#'   session
#'   
#'   \item \code{\link{download_ts}} - downloads data from SB into a 
#'   file
#'   
#'   }
#'   
#' @section interactive data exploration:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{explore_map}} - explore site metadata with a 
#'   map interface in a web browser
#'   
#'   \item \code{\link{explore_timeseries}} - explore timeseries data with a 
#'   graph interface in a web browser
#'   
#'   }
#'   
#' @section Other data types on ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{upload_presentation}} - uploads a presentation to the 
#'   Presentations folder on SB
#'   
#'   \item \code{\link{upload_publication}} - uploads a presentation to the 
#'   Publications folder on SB
#'   
#'   }
#'   
#' @section Internal functions:
#'   
#'   \itemize{
#'   
#'   \item \code{.url_from_id} - given an item ID, produces a URL that 
#'   will take you to that item
#'   
#'   }
#'   
#' @docType package
#' @name powstreams
NULL