#' Random Chuck Norris facts
#'
#' Query the internet Chuck Norris database (ICNDb) for a random Chuck Norris
#' fact.
#'
#' @param n Integer specifying the number of random facts to return. Default is
#' \code{1}.
#'
#' @param include Character string specifying the category of the joke. Default
#' is \code{NULL} meaning use all available categories in the query. The
#' available categories can be viewed using \code{fetch_categories()}.
#' (Currently ignored.)
#'
#' @param exclude Character string specifying the categories to exclude.
#' Default is \code{NULL} meaning use all available categories in the query.
#' The available categories can be viewed using \code{fetch_categories()}.
#' (Currently ignored.)
#'
#' @param sound Logical indicatin whether or not "Chuck Norris" should be
#' shouted when generating random facts. Default is \code{FALSE}.
#'
#' @param sound_repeat Integer specifying the number of times the sound should
#' be repeated. Default is 1. (Only matters if \code{sound = TRUE}.)
#'
#' @return An object of class \code{"random_fact"}; essentially a character
#' vector.
#'
#' @rdname random_fact
#'
#' @export
#'
#' @examples
#' # Generate a random fact
#' random_fact()
#'
#' # Generate multiple random facts
#' random_fact(3, sound = TRUE)
random_fact <- function(n = 1L, include = NULL, exclude = NULL, sound = FALSE,
                        sound_repeat = 1) {

  # Play awesome sound (If requested)
  if (sound) {
    if (!requireNamespace("magick", quietly = TRUE)) {
      stop("The tuneR package is required when setting `sound = TRUE` for ",
           "additional awesomeness.", call. = FALSE)
    }
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

  # Return random fact(s)
  roundhouse::facts[["fact"]][sample(nrow(roundhouse::facts), size = n,
                                     replace = FALSE)]

}
