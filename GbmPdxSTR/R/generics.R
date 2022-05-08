# makes first col. the header
# meant to prep input query data when entered directly
# in the app intead of csv
add_header <- function(df) {
  names(df) <- as.character(unlist(df[1,]))
  df[-1,]
}


#------pre-process upload------
process_upload <- function(input_path) {

  # process upload to add it to expected format (wider and comma-separated per allele)
  user_query_upload <- read.csv(input_path, header = TRUE, colClasses = "character")

  # remove any homozygous values if present
  user_query_upload <- as.data.frame(t(apply(user_query_upload, 1, function(x) replace(x, duplicated(x), NA))))

  user_query_upload %>%
    dplyr::mutate_all(as.character) %>% # ensure all is character
    tidyr::unite(STR_data, -GBM, -Marker, remove = TRUE, na.rm = TRUE, sep = ",") %>%
    tidyr::pivot_wider(names_from = Marker, values_from = STR_data) %>% # make it wide
    dplyr::na_if(., "") %>% # re-add NAs for any STRs where there is no data
    tibble::column_to_rownames(., "GBM") -> user_query_upload

  return(user_query_upload)
}
