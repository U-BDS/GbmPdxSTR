#' add_query_alleles_data
#' Adds the total number of alleles for the query and return a data.frame in the format
#' which will be viewed in the app - e.g.: allele values being comma separated
#' @param query query data
#' @param include_amel logical indicating whether to include Amelogenin in score computation
#'
#' @return A new query data.frame containing the number of total alleles in the data.frame format
#' needed by the app
#' @export
#' @import dplyr
#'
#' @examples
#' \dontrun{
#' add_query_alleles_data(query)
#' }
add_query_alleles_data <- function(query, include_amel = TRUE) {

  stopifnot(is.logical(include_amel))

  # compute total number of alleles for query
  total_alleles_query <- setNames(data.frame(matrix(ncol = length(markers_ref), nrow = 1)), markers_ref)

  for (marker in markers_ref) {
    query_total <- length(
      na.omit(
        strsplit(query[rownames(query), marker], split = ",")[[1]]
      )
    )

    total_alleles_query[, marker] <- query_total

    total_alleles_query$GBM <- rownames(query)
  }

  if (include_amel == FALSE) {
    total_alleles_query <- dplyr::select(total_alleles_query, -Amel)
  }

  # summarizing the data
  total_alleles_query <- summarize_allele_stats(
    total_alleles_query,
    new_column_name = "total_alleles",
    perform_binding = FALSE
  )

  query %>%
    tibble::rownames_to_column(var = "GBM") -> output_df

  output_df <- plyr::join_all(
    list(output_df, total_alleles_query),
    by = "GBM",
    type = "full"
  )

  # adding data_type variable for use of `RowGroup` later on in DT

  output_df$data_type <- "query"

  return(output_df)
}
