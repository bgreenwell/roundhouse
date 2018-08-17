#' Roundhouse
#'
#' Generate a random Chuck Norris fact with a roundhouse kick.
#'
#' @param text Character string specifying the text to display with the
#' roundhouse (preferably, a Chuck Norris fact). If \code{NULL}, a fact is
#' selected at random from the ICNDb.
#'
#' @param width Integer specifying the number of characters per line.
#'
#' @param color Character string specifying the color of the text.
#'
#' @param fps Integer specifying the frames per second of the roundhouse kick.
#'
#' @param loop Integer specifying the number of times the roundhouse kick should
#' be repeated. Though a single roundhouse kick is always sufficient, the
#' default is \code{0} which results in an infinite number of roundhouse kicks.
#'
#' @param ... Additional optional arguments to be passed onto
#' \code{\link[magick]{image_annotate}}.
#'
#' @export
#'
#' @examples
#' roundhouse(width = 40, size = 15)
#'
#' roundhouse("Chuck Norris can’t test for equality because he has no equal.",
#'            width = 40, size = 25, fps = 5)
roundhouse <- function(text = NULL, width = 15, color = "white", fps = NULL,
                       loop = 0, ...) {
  if (is.null(text)) {
    text <- gsub(
      pattern = "&quot;",
      replacement = "'",
      x = random_fact()[["content"]][["value"]][[1L]][["joke"]]
    )
  }
  text <- paste0(strwrap(text, width = width), collapse = "\n")
  gif <- magick::image_read(
    path = "https://media.giphy.com/media/l1J3nY7N7LBrBobVm/giphy.gif"
  )
  if (is.null(fps)) {
    magick::image_annotate(gif, text = text, color = color, ...)
  } else {
    magick::image_animate(
      image = magick::image_annotate(gif, text = text, color = color, ...),
      fps = fps,
      dispose = "none",
      loop = loop
    )
  }
}
