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
#' \dontrun{
#' # Generate a random fact
#' random_fact()
#'
#' # Generate multiple random facts
#' random_fact(3)
#' }
random_fact <- function(n = 1L, include = NULL, exclude = NULL, sound = FALSE,
                        sound_repeat = 1) {

  # Query the ICNDb API
  # url <- modify_url("http://api.icndb.com/jokes/random/", path = n)
  url <- paste0("http://api.icndb.com/jokes/random/", n)
  resp <- httr::GET(url)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  # Parse the returned JSON file
  parsed <- jsonlite::fromJSON(httr::content(resp, as = "text"),
                               simplifyVector = FALSE)

  # Turn API errors into R errors
  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "ICNDb API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  # Play awesome sound
  if (sound) {
    for (i in seq_len(sound_repeat)) {
      if (Sys.info()["sysname"] == "Darwin") {
        tuneR::play(tuneR::readMP3("inst/sounds/chuck-norris.mp3"),
                    player = "/usr/bin/afplay")
      } else {
        tuneR::play(tuneR::readMP3("inst/sounds/chuck-norris.mp3"))
      }
    }
  }

  # Return a random_fact object (a list)
  structure(
    list(
      "content" = parsed,
      "response" = resp
    ),
    class = "random_fact"
  )

}


#' @keywords internal
#'
#' @export
print.random_fact <- function(x, ...) {
  print(unlist(lapply(x$content$value, function(y) {
    gsub("&quot;", replacement = "'", x = y[["joke"]])
  })))
  invisible(x)
}


#' Fetch available categories
#'
#' Fetch all available Chuck Norris fact categories.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Fetch all available fact categories
#' fetch_categories()
#' }
fetch_categories <- function() {

  # Query ICNDb API
  url <- "http://api.icndb.com/categories"
  resp <- httr::GET(url)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  # Parse the returned JSON file
  parsed <- jsonlite::fromJSON(httr::content(resp, as = "text"),
                               simplifyVector = FALSE)

  # Turn API errors into R errors
  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "ICNDb API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  # Return vector of categories
  unlist(parsed$value)

}
