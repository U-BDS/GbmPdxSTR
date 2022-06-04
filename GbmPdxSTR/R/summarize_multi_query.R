#' summarize_multi_query
#' Provides a summary of the scores from a multi-query search
#' @param multi_query_list a list of processed queries - typically the output of `process_multi_query`
#'
#' @return A data.frame which contains summary scores of each STR marker per sample.
#' @export
#'
#' @examples
#' \dontrun{
#' summarize_multi_query(process_multi_query("./data/multi_query_example.csv")) #note nested `process_multi_query`
#' }
summarize_multi_query <- function(multi_query_list) {

  scores_list <- mapply(FUN = function(x) {
    # selecting only columns for score summary
    x <- dplyr::select(x, GBM, Score, data_type)

    # subset by query and reference
    query <- subset(x, data_type == "query") # for sample name

    reference_scores <- subset(x, data_type == "reference")
    reference_scores <- dplyr::select(reference_scores, -data_type)
    reference_scores <- add_header(
      as.data.frame(t(reference_scores))
    )

    # re-add sample name
    reference_scores$GBM <- query$GBM

    return(reference_scores)
  }, x = multi_query_list, SIMPLIFY = FALSE)

  # from list make a single data.frame of the summarized data
  score_summary <- dplyr::bind_rows(scores_list)

  rownames(score_summary) <- NULL

  score_summary %>%
    tibble::column_to_rownames(var = "GBM") -> score_summary

  # make it numeric to apply styleColorBar in DT across entire table
  score_summary[] <- lapply(score_summary, function(x) as.numeric(as.character(x)))

  return(score_summary)

}
