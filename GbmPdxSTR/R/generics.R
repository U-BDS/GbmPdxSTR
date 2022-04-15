# makes first col. the header
# meant to prep input query data when entered directly
# in the app intead of csv
add_header <- function(df) {
  names(df) <- as.character(unlist(df[1,]))
  df[-1,]
}
