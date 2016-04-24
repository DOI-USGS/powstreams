#' Bring one or more timeseries into R and merge them
#' 
#' The timeseries are iteratively joined, starting by joining the second element
#' of \code{var_src} to the first, then adding in the third, etc. This method 
#' means you have control, not just through the \code{method} and 
#' \code{approx_tol} arguments but also through how you order the elements of 
#' \code{var_src}, with consequences for the size and contents of the resulting 
#' data.frame.
#' 
#' Downloads each file from SB if either (1) the file has not yet been 
#' downloaded to the code{tempdir()} during this R session, or (2) 
#' \code{on_local_exists='replace'}. There's a small risk that the resulting ts 
#' will be out of date relative to ScienceBase, but the benefit is faster 
#' ts-getting.
#' 
#' @usage get_ts(var_src, site_name, method = c("approx", "full_join",
#'   "left_join", "inner_join"), approx_tol = as.difftime(3, units = "hours"), 
#'   version = c("rds", "tsv"), on_local_exists = "skip", on_invalid = "warn",
#'   match_var = "leftmost", condense_stat = mean, day_start = 4, day_end = 28,
#'   quietly = FALSE)
#' @param var_src a valid variable name for timeseries data (see 
#'   \code{\link{get_ts_metadata}()$var_src})
#' @param site_name a valid powstreams site (see \code{\link{list_sites}()})
#' @param method character specifying the method to use to combine timeseries 
#'   datasets
#' @param approx_tol difftime. Ignored if method != 'approx'. If method == 
#'   'approx', the maximum time interval over which an approximation will be 
#'   used to fill in data gaps (relative to the variable identified in 
#'   \code{match_var})
#' @param version character string indicating whether you want to download the 
#'   ts as a .tsv or .rds
#' @param match_var character string indicating which variable's timesteps the 
#'   resulting data.frame should match. The string must also be in `var_src`. 
#'   The default chooses the first variable listed in `var_src`.
#' @param condense_stat function name used to condense observations to 
#'   `match_var`'s timestep (only for variables with more frequent observations 
#'   than `match_var`), or the term `match` to indicate that the function 
#'   defined in `method` will be used to match the timestep of `match_var`. 
#'   Function names should be unquoted, where as `match` should be string. 
#'   Examples of what to use: mean (default), median, max, and min. A custom 
#'   function can also be used, but it's input must be a numeric vector and 
#'   output must be a single numeric value.
#' @param day_start start time (inclusive) of a day's data in number of hours 
#'   from the midnight that begins the date. For example, day_start=-1.5 
#'   indicates that data describing 2006-06-26 begin at 2006-06-25 22:30, or at 
#'   the first observation time that occurs after that time if day_start doesn't
#'   fall exactly on an observation time. For metabolism models working with 
#'   single days of input data, it is conventional/useful to begin the day the 
#'   evening before, e.g., -1.5, and to end just before the next sunrise, e.g., 
#'   30. For multiple consecutive days, it may make the most sense to start just
#'   before sunrise (e.g., 4) and to end 24 hours later. For nighttime 
#'   regression, the date assigned to a chunk of data should be the date whose 
#'   evening contains the data. The default is therefore 12 to 36 for 
#'   metab_night, of which the times of darkness will be used.
#' @param day_end end time (exclusive) of a day's data in number of hours from 
#'   the midnight that begins the date. For example, day_end=30 indicates that 
#'   data describing 2006-06-26 end at the last observation time that occurs 
#'   before 2006-06-27 06:00. See day_start for recommended start and end times.
#' @param quietly logical. if one or more timeseries will be truncated, padded 
#'   with NAs, or condensed, should a warning message be given?
#' @param on_local_exists character indicating what to do if the folder already 
#'   contains a file with the intended download name
#' @param on_invalid character in \code{c("stop","warn")} indicating how to 
#'   handle invalid timeseries
#'   
#' @importFrom mda.streams get_ts
#' @name get_ts
#' @rdname get_ts
#' @export
NULL