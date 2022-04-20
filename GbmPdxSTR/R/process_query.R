#' process_query
#' Process single-query entries to produce a summarized data.frame containing STR matching scores
#' @param query query data
#' @param ... params to be passed on to `add_scores` - typically linked to choice to scoring algorithm
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' process_query(query, scoring_algorithm = "tanabe")
#' process_query(query, scoring_algorithm = "masters", masters_denominator = "query")
#' process_query(query, scoring_algorithm = "masters", masters_denominator = "reference")
#' }
process_query <- function(query, ...) {

  # compiling everything to generate final single-query output

  # compute total and shared
  query_alleles_data <- add_query_alleles_data(query)
  ref_alleles_data <- add_share_ref_alleles_data(query)

  # compute matching score

  matching_scores_to_ref <- add_scores(
    ref_alleles_data = ref_alleles_data,
    query_alleles_data = query_alleles_data,
    ...
  )

  # bind processed query to ref containing score to generate final single-query output
  single_query_output <- dplyr::bind_rows(
    query_alleles_data,
    matching_scores_to_ref
  )

  # moving allele numbers/score etc.
  single_query_output <- dplyr::relocate(
    single_query_output,
    Score, shared_alleles, total_alleles,
    .after = GBM
  )

  return(single_query_output)
}
