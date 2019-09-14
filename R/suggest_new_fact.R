#' Suggest new Chuck Norris facts
#'
#' Have a new Chuck Norris fact you want added to the database? Use this
#' function to open a new issue on roundhouse's GitHub page. If it's good, I'll
#' be sure to include it in the next release!
#'
#' @param fact Character string specifying a new Chuck Norris fact.
#'
#' @param user Character string specifying a valid GitHub username.
#'
#' @param password Character string specifying a valid password associated with
#' the above GitHub username.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' request_new_fact}
suggest_new_fact <- function(fact, user, password) {
  if (!requireNamespace("httr", quietly = TRUE)) {
    stop("The httr package is required for requesting new facts.",
         call. = FALSE)
  }
  r <- httr::POST(
    url = "https://api.github.com/repos/bgreenwell/roundhouse/issues",
    body = list(
      "title" = "New Chuck Norris Fact",
      "body" = fact
      # "labels" = "enhancement"
    ),
    encode = "json",
    httr::authenticate(user = user, password = password)
  )
  if (r$status_code == 201) {
    message("Request successfully submitted: ", r$headers$location)
  } else {
    message("Request was unsuccessful. Status code: ", r$status_code)
  }
}
