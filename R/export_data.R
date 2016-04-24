#' Export data to a local text file
#' 
#' @param data a data.frame or unitted_data.frame of data
#' @param file the file to write to, as in \code{\link{write.table}}
#' @param keep.units logical. if data has units, should these be written as a
#'   second line (just beneath the header) in the text file?
#' @param comment.char a single character, or "", with which to prepend the line
#'   containing units information
#' @param sep the character string used to separate columns, as in 
#'   \code{\link{write.table}}
#' @param row.names logical. whether to write row names to the file, as in 
#'   \code{\link{write.table}}
#' @param quote logical. whether to place quotes around every data entry, as in 
#'   \code{\link{write.table}}
#' @param ... other arguments passed to \code{\link{write.table}}
#'   
#' @seealso \code{\link[unitted]{write_unitted}}, \code{\link{write.table}}
#' @export
export_data <- function(data, file="", keep.units=is.unitted(data), comment.char = "#", sep = "\t", row.names = FALSE, quote = FALSE, ...) {
  if(is.unitted(data) & isTRUE(keep.units)) {
    write_unitted(data, file=file, comment.char=comment.char, sep=sep, row.names=row.names, quote=quote, ...)
  } else {
    write.table(v(data), file=file, sep=sep, row.names=row.names, quote=quote, ...)
  }
  invisible(file)
}