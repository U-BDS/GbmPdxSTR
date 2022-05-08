validate_marker_query <- function(query) {
  # remove any empty spaces if present
  query <- mutate(query,
                  across(where(is.character), stringr::str_remove_all, pattern = fixed(" ")))

  # ensure any empty entries are NAs
  query <- dplyr::na_if(query, "")

  # ensure that for Amel, expected inputs are valid
  if (!is.na(query$Amel)) {
    query$Amel <- toupper(query$Amel)

    #TODO: need to change to ensure inputs are only X, Y....
    validate(
      need("X" %in% unlist(strsplit(query$Amel,",")) | "Y" %in% unlist(strsplit(query$Amel,",")),
           message = paste0("Amel marker input ", query$Amel, " does not match expected inputs (X or X,Y)"))
    )
  }

  # for all other markers check if input can be converted to numeric
  lapply(select(query, -Amel), function(col_input) {

    if (!is.na(col_input)) {
      validate(
        need(!any(!stringr::str_detect(unlist(strsplit(col_input,",")),"^[0-9]+[.]?[0-9]*$")),
             message = paste0("Input ", col_input, " should be numeric values (10, or 10,11 etc.)"))
      )
    }
  })

  return(query)
}

#TODO: add function description
