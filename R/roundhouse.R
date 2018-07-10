#' Roundhouse
#'
#' Generate a random Chuck Norris fact with a roundhouse kick.
#'
#' @param width Integer specifying the number of characters per line.
#'
#' @param color Character string specifying the color of the text.
#'
#' @param ... Additional optional arguments to be passed onto
#' \code{\link[magick]{image_annotate}}.
#'
#' @export
#'
#' @examples
#' roundhouse(width = 40, size = 15)
roundhouse <- function(width = 15, color = "white", ...) {
  url <- "https://media.giphy.com/media/l1J3nY7N7LBrBobVm/giphy.gif"
  fact <- random_fact()[["content"]][["value"]][[1L]][["joke"]]
  fact <- gsub("&quot;", replacement = "'", x = fact)
  fact <- paste0(strwrap(fact, width = width), collapse = "\n")
  gif <- magick::image_read(url)
  magick::image_annotate(gif, text = fact, color = color, ...)
}
