#' Roundhouse kick
#'
#' Generate a roundhouse kick from Chuck Norris...with a random fact (or user-
#' supplied text).
#'
#' @param text Character string specifying the text to display with the
#' roundhouse (preferably, a Chuck Norris fact). If \code{NULL}, a fact is
#' selected at random from the ICNDb.
#'
#' @param type Integer specifying which roundhouse kick to generate. Current
#' options are 1 (standard roundhouse kick) or 2 (roundhouse kick bad guy
#' through bar window). Default is 1.
#'
#' @param width Integer specifying the number of characters per line. Default is
#' 35
#'
#' @param size Integer specifying the font size in pixels. Defaul is 10.
#'
#' @param color Character string specifying the color of the text.
#'
#' @param fps Integer specifying the frames per second of the roundhouse kick.
#' (Must be a factor of 100.)
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
#' # Random fact
#' kick(width = 40, size = 15)
#'
#' # User-supplied text
#' kick("Chuck Norris can’t test for equality because he has no equal.",
#'      type = 2, width = 40, size = 25, fps = 5)
kick <- function(text = NULL, type = 1, width = 35, size = 20, color = "white",
                 fps = NULL, loop = 0, ...) {
  if (!requireNamespace("magick", quietly = TRUE)) {
    stop("The magick package is required for roundhouse kicks.", call. = FALSE)
  }
  if (!(type %in% 1:2)) {
    stop("Argument `type` must be 1 or 2.")
  }

  if (is.null(text)) {
    text <- gsub(
      pattern = "&quot;",
      replacement = "'",
      x = random_fact()[["content"]][["value"]][[1L]][["joke"]]
    )
  }
  path <- system.file("extdata", paste0("kick-0", type, ".gif"),
                      package = "roundhouse")
  text <- paste0(strwrap(text, width = width), collapse = "\n")
  gif <- magick::image_read(
    # path = "https://media.giphy.com/media/l1J3nY7N7LBrBobVm/giphy.gif"
    path = path
  )
  if (is.null(fps)) {
    magick::image_annotate(
      image = gif, text = text, color = color, size = size, ...
    )
  } else {
    magick::image_animate(
      image = magick::image_annotate(
        image = gif, text = text, color = color, size = size, ...
      ),
      fps = fps,
      dispose = "none",
      loop = loop
    )
  }
}
