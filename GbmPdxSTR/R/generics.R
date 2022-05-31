# makes first col. the header
# meant to prep input query data when entered directly
# in the app instead of csv
add_header <- function(df) {
  names(df) <- as.character(unlist(df[1, ]))
  df[-1, ]
}


#------pre-process upload------
process_upload <- function(input_path) {

  # process upload to add it to expected format (wider and comma-separated per allele)
  user_query_upload <- read.csv(input_path, header = TRUE, colClasses = "character")

  # remove any homozygous values if present (to be counted as one allele)
  user_query_upload <- as.data.frame(t(apply(user_query_upload, 1, function(x) replace(x, duplicated(x), NA))))

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

#TODO: add function description to all generics
