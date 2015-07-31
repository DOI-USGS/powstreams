#' High-level functions for accessing the Continental Stream Metabolism data
#' 
#' This package contains functions that make it easy for R users to use the 
#' Powell Center project data in particular. For lower-level functions specific 
#' to the Powell Center project, see \pkg{mda.streams}, and for still 
#' lower-level functions generic to all ScienceBase tasks, see \pkg{sbtools}.
#' 
#' @section Interactively exploring data:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{explore_map}} - explore site metadata with an interactive
#'   map in a web browser
#'   
#'   \item \code{\link{explore_timeseries}} - explore timeseries data with 
#'   interactive graphs in a web browser
#'   
#'   \item \code{\link{explore_model}} - explore a metabolism model with 
#'   interactive graphs in a web browser
#'   
#'   }
#'   
#' @section Logging in:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{login_sb}}
#'   
#'   }
#'   
#' @section Querying ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{list_sites}}
#'   
#'   \item \code{\link{list_tses}}
#'   
#'   \item \code{\link{summarize_ts}}
#'   
#'   \item \code{\link[mda.streams]{list_metab_runs}}
#'   
#'   \item \code{\link[mda.streams]{list_metab_run_files}}
#'   
#'   }
#'   
#' @section Navigating ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{locate_folder}}
#'   
#'   \item \code{\link{locate_meta}}
#'   
#'   \item \code{\link{locate_metab_model}}
#'   
#'   \item \code{\link{locate_metab_run}}
#'   
#'   \item \code{\link{locate_site}}
#'   
#'   \item \code{\link{locate_ts}}
#'   
#'   }
#'
#' @section Reading data from ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{list_sites}} - get a list of sites on SB
#'   
#'   \item \code{\link{get_site_info}} - reports basic site information
#'   
#'   \item \code{\link{view_google_map}} - reports basic site information
#'   
#'   \item \code{\link{get_meta}} - loads site (meta) data from SB into R
#'   
#'   \item \code{\link{get_meta_metadata}} - get info about site (meta) data
#'   
#'   \item \code{\link{list_tses}} - get a list of tses for a site on SB
#'   
#'   \item \code{\link{get_ts}} - loads data from SB into R
#'   
#'   \item \code{\link{get_ts_metadata}} - get info about ts data
#'
#'   }
#'   
#' @section Exporting data from R to text:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{export_data}} - exports data from R into a text file
#'   
#'   \item \code{\link{view_file}}
#'   
#'   \item \code{\link{view_folder}}
#'   
#'   }
#'   
#' @section Reading models from ScienceBase:
#'   
#'   \itemize{
#'   
#'   \item \code{\link{get_config}} - gets a config file from SB
#'   
#'   \item \code{\link{get_metab_model}} - gets a metab_model object from SB
#'
#'   }
#'   
#' @section Other actions for ScienceBase:
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
#' @docType package
#' @name powstreams
NULL