#' process_upload
#' Helper function to pre-process csv uploads to correctly formatted table required by the app.
#' It will also ensure that homozygous alleles are counted as one, and handles any STR aliases.
#' @param input_path the path to the query csv file expected by the app
#'
#' @return A data.frame in the format that expected for further processing within the app
#' @export
#' @import dplyr
#'
#' @examples
#' \dontrun{
#' process_upload("./data/single_query_example.csv")
#' }
process_upload <- function(input_path) {

  # process upload to add it to expected format (wider and comma-separated per allele)
  user_query_upload <- utils::read.csv(input_path, header = TRUE, colClasses = "character")

  # check that expected columns are present

  validate(
    need(ncol(user_query_upload) == 6,
      message = paste0(
        "Unexpected number of columns found! Ensure there are 6 columns ",
        "named GBM, Marker, Allele_1, Allele_2, Allele_3, Allele_4"
      )
    )
  )

  # col order shouldn't affect app behavior, thus sorting
  setdiff_out <- setdiff(
    sort(colnames(user_query_upload)),
    sort(c("GBM", "Marker", "Allele_1", "Allele_2", "Allele_3", "Allele_4"))
  )
  validate(
    need(length(setdiff_out) == 0,
      message = paste0(
        "Unexpected column names found! The column(s) named ", setdiff_out,
        " differ from one or more of the following GBM, Marker, Allele_1, Allele_2, Allele_3, Allele_4"
      )
    )
  )

  # remove any homozygous values if present (to be counted as one allele)
  user_query_upload <- as.data.frame(t(apply(user_query_upload, 1, function(x) replace(x, duplicated(x), NA))))

  # validate that a sample name and/or marker per sample is not present more than once
  # (would indicate duplicates in sample names and/or markers per sample)

  user_query_upload %>%
    count(GBM, Marker) -> sample_marker_count_check

  validate(
    need(all(sample_marker_count_check$n == 1),
      message = paste0(
        "It looks like you have duplicates in sample names and/or markers per sample. ",
        "Ensure samples contain unique names and marker types."
      )
    )
  )

  user_query_upload %>%
    dplyr::mutate_all(as.character) %>% # ensure all is character
    tidyr::unite(STR_data, -GBM, -Marker, remove = TRUE, na.rm = TRUE, sep = ",") %>%
    tidyr::pivot_wider(names_from = Marker, values_from = STR_data) %>% # make it wide
    dplyr::na_if(., "") %>% # re-add NAs for any STRs where there is no data
    tibble::column_to_rownames(., "GBM") -> user_query_upload

  # rename col names which contain aliases

  amel_aliases <- c("Amelogenin", "AM", "Aml", "AMEL")

  if (any(amel_aliases %in% colnames(user_query_upload))) {
    user_query_upload <- dplyr::rename(user_query_upload,
      Amel = amel_aliases[which(amel_aliases %in% colnames(user_query_upload))]
    )
  }

  # since in current input Penta STRs are values of a variable rather than columns themselves
  # manually change this here to the R suitable col names, but allow these names to be
  # provided as aliases in the original user file
  if ("Penta D" %in% colnames(user_query_upload)) {
    user_query_upload <- dplyr::rename(user_query_upload,
      "Penta.D" = "Penta D"
    )
  }

  if ("Penta E" %in% colnames(user_query_upload)) {
    user_query_upload <- dplyr::rename(user_query_upload,
      "Penta.E" = "Penta E"
    )
  }

  return(user_query_upload)
}
