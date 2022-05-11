validate_marker_query <- function(query, input_type = c("manual_entry", "csv")) {
  # evaluate input type:
  input_type <- match.arg(input_type)

  # remove any empty spaces if present
  query <- mutate(
    query,
    across(where(is.character), stringr::str_remove_all, pattern = stringr::fixed(" "))
  )

  # ensure any empty entries are NAs
  query <- dplyr::na_if(query, "")

  # ensure that for Amel, expected inputs are valid
  if (!is.na(query$Amel)) {
    query$Amel <- toupper(query$Amel)

    validate(
      need(all(unlist(strsplit(query$Amel, ",")) == "X") | all(unlist(strsplit(query$Amel, ",")) == "Y") | all(sort(unique(unlist(strsplit(query$Amel, ",")))) == c("X", "Y")),
        message = paste0("Amel marker input ", query$Amel, " does not match expected inputs (X or X,Y)")
      )
    )
  }

  # for all other markers check if input can be converted to numeric
  lapply(select(query, -Amel), function(col_input) {
    if (!is.na(col_input)) {
      validate(
        need(!any(!stringr::str_detect(unlist(strsplit(col_input, ",")), "^[0-9]+[.]?[0-9]*$")),
          message = paste0("Input ", col_input, " should be numeric values (10, or 10,11 etc.)")
        )
      )
    }
  })

  # for all markers remove homozygous (already done in upload csv but not in user-entered data)
  if (input_type == "manual_entry") {
    for (i in 1:ncol(query)) {
      if (!is.na(query[, i])) {
        unique_entry <- paste0(unique(unlist(strsplit(query[, i], ","))),
          collapse = ","
        )

        if (unique_entry != query[, i]) {
          # showNotification(paste0("Homozygous alleles detected in ", query[, i] , " removing them now"),
          #   type = "message",
          #   duration = 8
          # ) #TODO: if issue with eventReactive is resolved, re-enable this

          query[, i] <- unique_entry
        }
      }
    }
  }

  return(query)
}

# TODO: add function description
# TODO: add helper message about inputs up top and mention homozygous alleles are removed
