#' process_multi_query
#' Process multi-queries from a csv file
#'
#' @param input_path the path to the multi-query csv file expected by the app
#' @param ... params to be passed on to `process_query`
#'
#' @return A list of processed queries
#' @export
#'
#' @examples
#' \dontrun{
#' process_multi_query("./data/multi_query_example.csv") # default params
#' process_multi_query("./data/multi_query_example.csv",
#'   include_amel = TRUE,
#'   scoring_algorithm = "tanabe"
#' ) # same as default
#' process_multi_query("./data/multi_query_example.csv",
#'   include_amel = FALSE,
#'   scoring_algorithm = "masters", masters_denominator = "query"
#' )
#' }
process_multi_query <- function(input_path, ...) {
  multi_query <- process_upload(input_path)

  # make list out of the uploaded multi-query
  multi_query_list <- setNames(split(multi_query, seq(nrow(multi_query))), rownames(multi_query))

  # automate process over every element of the list
  multi_query_list <- mapply(FUN = function(x) {

    # validate entries for all markers
    x <- validate_marker_query(x, input_type = "csv")

    # process_query
    x <- process_query(query = as.data.frame(x), ...)

    return(x)
  }, x = multi_query_list, SIMPLIFY = FALSE)

  return(multi_query_list)
}
