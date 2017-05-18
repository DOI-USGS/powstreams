#' Log into ScienceBase with your myUSGS credentials
#' 
#' BE CAREFUL NOT TO POST OR SHARE YOUR PASSWORD! Use the same username and 
#' password you set up via the ScienceBase interface or your government 
#' employer. This function is equivalent to 
#' \code{sbtools::\link[sbtools]{authenticate_sb}} but easier to type.
#' 
#' @usage login_sb(username, filename='~/.R/stream_metab.yaml')
#' @param username Your ScienceBase/myUSGS username, usually an email address
#' @param filename The file path to a yaml file where fields for sb_user and
#'   sb_password can be found. This file will be ignored if \code{username} is
#'   given.
#'   
#' @importFrom mda.streams login_sb
#' @name login_sb
#' @rdname login_sb
#' @export
NULL