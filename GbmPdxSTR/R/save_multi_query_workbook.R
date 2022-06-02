#' save_multi_query_workbook
#' Saves a processed multi-query to an Excel spreadsheet where each resulting query is in a tab.
#'
#' @param multi_query_list a list of processed queries - typically the output of `process_multi_query`
#' @param file_output_name output `xlsx` file name
#'
#' @return An excel spreadsheet which contains the multi-query results - one query per tab
#' @export
#'
#' @examples
#' \dontrun{
#' save_multi_query_workbook(process_multi_query("./data/multi_query_example.csv")) #note nested `process_multi_query`
#' }
save_multi_query_workbook <- function(multi_query_list, file_output_name = "GBM_PDX_STR_multi_query.xlsx") {

  # create to a tabbed spreadsheet
  wb <- openxlsx::createWorkbook()

  # iterate over all elements of the list
  mapply(FUN = function(x, y) {

    openxlsx::addWorksheet(wb, sheetName = y)

    openxlsx::writeData(wb, sheet = y, x = x)

  }, x = multi_query_list, y = names(multi_query_list), SIMPLIFY = FALSE)

  # save as excel
  openxlsx::saveWorkbook(wb, file = file_output_name, overwrite = TRUE)

}
