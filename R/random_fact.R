#' Random Chuck Norris Fact
#'
#' Query the internet Chuck Norris databse (ICNDb) for a random Chuck Norris
#' fact.
#'
#' @param n Integer specifying the number of random facts to return. Default is
#' \code{1}.
#'
#' @param include Character string specifying the category of the joke. Default
#' is \code{NULL} meaning use all available categories in the query. The
#' available categories can be viewed using \code{fetch_categories()}.
#'
#' @param exclude Character string specifying the categories to excluse.
#' Currently ignored. Default is \code{NULL} meaning use all available
#' categories in the query. The available categories can be viewed using
#' \code{fetch_categories()}.
#'
#' @return An object of class \code{"random_fact"}; essentially a character
#' vector.
#'
#' @rdname random_fact
#'
#' @export
#'
#' @examples
#' random_fact()
random_fact <- function(n = 1L, include = NULL, exclude = NULL) {

  # Query the NPPES API
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
        status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  # Return a nppes_api object (a list)
  structure(
    list(
      "content" = parsed,
      "response" = resp
    ),
    class = "random_fact"
  )

}


#' @rdname random_fact
#'
#' @export
print.random_fact <- function(x, ...) {
  print(unlist(lapply(x$content$value, function(y) {
    gsub("&quot;", replacement = "'", x = y[["joke"]])
  })))
  # print.default(x$content$value[[1L]]$joke)
  invisible(x)
}
