#' Roundhouse punch
#'
#' Generate a roundhouse punch from Chuck Norris...with a random fact (or user-
#' supplied text).
#'
#' @param text Character string specifying the text to display with the
#' roundhouse (preferably, a Chuck Norris fact). If \code{NULL}, a fact is
#' selected at random from the ICNDb.
#'
#' @param width Integer specifying the number of characters per line. Default is
#' 35
#'
#' @param size Integer specifying the font size in pixels. Default is 10.
#'
#' @param color Character string specifying the color of the text.
#'
#' @param fps Integer specifying the frames per second of the roundhouse punch.
#' (Must be a factor of 100.)
#'
#' @param loop Integer specifying the number of times the roundhouse punch
#' should be repeated. Though a single roundhouse punch is always sufficient,
#' the default is \code{0} which results in an infinite number of roundhouse
#' punches.
#'
#' @param sound Logical indicatin whether or not "Chuck Norris" should be
#' shouted when generating random facts. Default is \code{FALSE}.
#'
#' @param sound_repeat Integer specifying the number of times the sound should
#' be repeated. Default is 1. (Only matters if \code{sound = TRUE}.)
#'
#' @param ... Additional optional arguments to be passed onto
#' \code{\link[magick]{image_annotate}}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Random fact
#' punch(width = 40, size = 15)
#'
#' # User-supplied text
#' punch("Chuck Norris can’t test for equality because he has no equal.",
#'      type = 2, width = 40, size = 25, fps = 5)
#' }
punch <- function(text = NULL, width = 35, size = 20, color = "white",
                  fps = NULL, loop = 0, sound = FALSE, sound_repeat = 1, ...) {
  if (!requireNamespace("magick", quietly = TRUE)) {
    stop("The magick package is required for roundhouse punches.",
         call. = FALSE)
  }
  if (is.null(text)) {
    text <- gsub(
      pattern = "&quot;",
      replacement = "'",
      x = random_fact()[["content"]][["value"]][[1L]][["joke"]]
    )
  }
  url <- "https://media.giphy.com/media/Fs8pXeLXuKUGA/giphy.gif"
  text <- paste0(strwrap(text, width = width), collapse = "\n")
  gif <- magick::image_read(path = url)
  res <- if (is.null(fps)) {
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

  # Play awesome sound(s)
  if (sound) {
    mp3_file <- system.file("sounds", "chuck-norris.mp3",
                            package = "roundhouse")
    for (i in seq_len(sound_repeat)) {
      if (Sys.info()["sysname"] == "Darwin") {
        tuneR::play(tuneR::readMP3(mp3_file), player = "/usr/bin/afplay")
      } else {
        tuneR::play(tuneR::readMP3(mp3_file))
      }
    }
  }

  # Print GIF
  res

}
