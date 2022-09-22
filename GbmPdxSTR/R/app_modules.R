# app modules
#-----------------------------------------global UI options----------------------------------------
options(spinner.type = 1, spinner.color = "#232a30", spinner.size = 2)

#-------------------------------------------UI-----------------------------------------------------

# margin-left: auto; margin-right: auto; for centering all textInputs
myModuleUI <- function(id) {
  ns <- NS(id)

  fluidPage(
    fluidRow(style = "background-color:#f5f5f5; max-width: 800px; margin-left:
             auto; margin-right: auto; border-style: solid; border-color: #e8e8e8",
      column(width = 4, align="center",
          mapply(FUN = function(x, y, z) {
            textInput(
              inputId = ns(x),
              label = y,
              width = "150px",
              placeholder = z
            )
            }, x = tolower(markers_ref[1:8]), y = markers_ref[1:8], z = placeholders[1:8], SIMPLIFY = FALSE)
      ),
      column(width = 4, align="center",
         mapply(FUN = function(x, y, z) {
           textInput(
             inputId = ns(x),
             label = y,
             width = "150px",
             placeholder = z
           )
         }, x = tolower(markers_ref[9:16]), y = markers_ref[9:16], z = placeholders[9:16], SIMPLIFY = FALSE)
      ),
      column(width = 4, align="center",
          shinyhelper::helper(shiny_tag = "", icon = "info-circle",
                              type = "markdown",
                              content = "marker_entry_info"),

          mapply(FUN = function(x, y, z) {
            textInput(
              inputId = ns(x),
              label = y,
              width = "150px",
              placeholder = z
            )
          }, x = tolower(markers_ref[17:24]), y = markers_ref[17:24], z = placeholders[17:24], SIMPLIFY = FALSE)
      ),
    ),
    br(),
    fluidRow(style = "background-color:#f5f5f5; max-width: 800px; margin-left:
             auto; margin-right: auto; border-style: solid; border-color: #e8e8e8",
             column(width = 6,
                    br(),
                    radioButtons(
                      inputId = ns("score"),
                      label = "Scoring algorithm",
                      choices = c("Tanabe" = "tanabe",
                                  "Masters (vs. query)" = "masters_query",
                                  "Masters (vs. reference)" = "masters_reference"),
                      width = "200px") %>%
                      shinyhelper::helper(icon = "info-circle",
                                          type = "markdown",
                                          content = "scoring_info"
                    ),
                    checkboxInput(
                      inputId = ns("count_amel"),
                      label = "Include Amelogenin in score computation",
                      value = TRUE,
                      width = "300px"
                    ),
                    fileInput(
                      inputId = ns("upload"),
                      label = "Optionally, upload CSV file of single-query data",
                      multiple = FALSE,
                      accept = ".csv",
                      width = "400px"
                    ) %>%
                      shinyhelper::helper(icon = "info-circle",
                                          type = "markdown",
                                          content = "csv_file_info"
                                          ),
                    downloadButton(ns("download_template"), label = "Download template csv file"),
             ),
             column(width = 6,
                    br(),
                    checkboxInput(
                      inputId = ns("hide"),
                      label = "Hide table from user manual query",
                      value = FALSE,
                      width = "300px"
                    ),
                    #br(),
                    checkboxInput(
                      inputId = ns("hidecsv"),
                      label = "Hide table from user csv upload",
                      value = FALSE,
                      width = "300px"
                    ),
             ),
    ),
    br(),
    verticalLayout(
      DT::DTOutput(ns("filtered_data")) # %>%
      #   shinycssloaders::withSpinner(),
      # ns = ns
    ),
    br(),
    verticalLayout(
      DT::DTOutput(ns("filtered_data_csv"))
    )
  )
}

########################################## MULTI-QUERY UI ############################################

myModuleUI_multi_query <- function(id) {
  ns <- NS(id)

  fluidPage(
    fluidRow(style = "background-color:#f5f5f5; max-width: 800px; margin-left:
             auto; margin-right: auto; border-style: solid; border-color: #e8e8e8",
             column(width = 6,
                    br(),
                    radioButtons(
                      inputId = ns("score_multi"),
                      label = "Scoring algorithm",
                      choices = c("Tanabe" = "tanabe",
                                  "Masters (vs. query)" = "masters_query",
                                  "Masters (vs. reference)" = "masters_reference"),
                      width = "200px") %>%
                      shinyhelper::helper(icon = "info-circle",
                                          type = "markdown",
                                          content = "scoring_info"
                      ),
                    checkboxInput(
                      inputId = ns("count_amel_multi"),
                      label = "Include Amelogenin in score computation",
                      value = TRUE,
                      width = "300px"
                    ),
                    selectInput(inputId = ns("reference_choice"),
                                label = "Choose to score based on app's reference (default) or custom reference",
                                choices = c("Default", "Custom"),
                                selected = c("Default"),
                                multiple = FALSE)  %>%
                      shinyhelper::helper(icon = "info-circle",
                                          type = "markdown",
                                          content = "custom_reference"
                      ),

                    #------- conditional panel based on user choice of reference-------

                    conditionalPanel(
                      condition = "input.reference_choice.indexOf('Custom') > -1",
                      fileInput(
                        inputId = ns("upload_reference"),
                        label = "Upload CSV file of custom reference",
                        multiple = FALSE,
                        accept = ".csv",
                        width = "400px"
                      ),
                      ns = ns),
             ),
             column(width = 6,
                    br(),

                    downloadButton(ns("download_template_multi"), "Download multi-query template csv file"),
                    br(),
                    br(),

                    fileInput(
                      inputId = ns("upload_multi"),
                      label = "Upload CSV file of multi-query data",
                      multiple = FALSE,
                      accept = ".csv",
                      width = "400px"
                    ) %>%
                      shinyhelper::helper(icon = "info-circle",
                                          type = "markdown",
                                          content = "multi_query_csv_file_info"
                      ),

                    downloadButton(ns("download_processed_data"), label = "Download multi-query detailed results") %>%
                      shinyhelper::helper(icon = "info-circle",
                                          type = "markdown",
                                          content = "download_multi_query"
                      ),
             ),
    ),
    br(),
    br(),
    verticalLayout(
      DT::DTOutput(ns("score_summary_multi_query_csv"))
    )
  )
}

#-------------------------------------------SERVER-----------------------------------------------------

myModuleServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      output$filtered_data <- DT::renderDT({

        input_data <- sapply(X = tolower(markers_ref), function(x) input[[x]])

        # create query d.f (order matches marker input)
        user_df <- data.frame(markers_ref, input_data)
        user_df <- as.data.frame(t(user_df))
        user_df <- add_header(user_df)

        # query inputs contain validation of each user-entered value by `validate_marker_query`
        user_df <- process_query(query = validate_marker_query(user_df, input_type = "manual_entry"),
                                 include_amel = input$count_amel,
                                 scoring_algorithm = sub("_.*", "", input$score),
                                 masters_denominator = sub(".*_", "", input$score))

        # output as DT::datatable
        DT::datatable(user_df,
                      rownames = FALSE,
                      extensions = "RowGroup",
                      options = list(
                        pageLength = 50,
                        scrollX = TRUE,
                        rowGroup = list(dataSrc = 2), # index here based is 0 based, not R based (index for `data_type` col)
                        escape = TRUE),
        ) %>%
          formatStyle(
            "Score",
            background = styleColorBar(c(0,100), "#dde0ed"), # use expected range from 0-100 for consistency across entire app
            backgroundSize = "98% 88%",
            backgroundRepeat = "no-repeat",
            backgroundPosition = "center"
          )

      })

      output$filtered_data_csv <- DT::renderDT({

        file_upload <- input$upload
        ext <- tools::file_ext(file_upload$datapath)

        req(file_upload)
        validate(need(ext == "csv", "Please upload a csv file"))

        #pre-process upload and validate user-entered inputs for each marker
        user_query_upload <- validate_marker_query(process_upload(file_upload$datapath), input_type = "csv")
        user_query_upload <- process_query(query = as.data.frame(user_query_upload),
                                           include_amel = input$count_amel,
                                           scoring_algorithm = sub("_.*", "", input$score),
                                           masters_denominator = sub(".*_", "", input$score))

        DT::datatable(user_query_upload,
                      rownames = FALSE,
                      extensions = "RowGroup",
                      options = list(
                        pageLength = 50,
                        scrollX = TRUE,
                        rowGroup = list(dataSrc = 2),
                        escape = TRUE),
        ) %>%
          formatStyle(
            "Score",
            background = styleColorBar(c(0,100), "#dde0ed"),
            backgroundSize = "98% 88%",
            backgroundRepeat = "no-repeat",
            backgroundPosition = "center"
          )

      })

      # sample csv download
      output$download_template <- downloadHandler(
        filename = "single_query_blank_template.csv",

        content = function(file) {
          write.csv(read.csv("./data/single_query_blank_template.csv"), file, row.names = FALSE)
        }
      )

      observe({
        shinyjs::toggle(id = "filtered_data",
                        condition = !(input$hide)
        )
      })

      observe({
        shinyjs::toggle(id = "filtered_data_csv",
                        condition = !(input$hidecsv)
        )
      })

    }
  )
}

########################################## MULTI-QUERY SERVER ############################################

myModuleServer_multi_query <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      output$score_summary_multi_query_csv <- DT::renderDT({

        #initial validation of multi-query upload
        file_upload <- input$upload_multi
        ext <- tools::file_ext(file_upload$datapath)

        req(file_upload)
        validate(need(ext == "csv", "Please upload a csv file"))

        # initial validation of reference upload and proper argument setting
        if (input$reference_choice == "Custom") {
          ref_upload <- input$upload_reference
          ext <- tools::file_ext(ref_upload$datapath)

          req(ref_upload)
          validate(need(ext == "csv", "Please upload a csv file"))

          reference <- ref_upload$datapath
        } else {
          reference <- "app_reference"
        }

        #process multi-query upload
        user_multi_query_upload <- process_multi_query(file_upload$datapath,
                                                       include_amel = input$count_amel_multi,
                                                       reference = reference,
                                                       scoring_algorithm = sub("_.*", "", input$score_multi),
                                                       masters_denominator = sub(".*_", "", input$score_multi))

        # output for summary scores
        summary_scores <- summarize_multi_query(user_multi_query_upload)

        DT::datatable(summary_scores,
                      rownames = TRUE,
                      options = list(
                        pageLength = 50,
                        scrollX = TRUE,
                        escape = TRUE),
        ) %>%
          formatStyle(
            names(summary_scores),
            background = styleColorBar(c(0,100), "#dde0ed"),
            backgroundSize = "98% 88%",
            backgroundRepeat = "no-repeat",
            backgroundPosition = "center"
          )

      })


      output$download_processed_data <- downloadHandler(
        filename = "GBM_PDX_STR_multi_query.xlsx",

        content = function(file) {

          #initial validation of multi-query upload
          file_upload <- input$upload_multi
          ext <- tools::file_ext(file_upload$datapath)

          req(file_upload)
          validate(need(ext == "csv", "Please upload a csv file"))

          # initial validation of reference upload and proper argument setting
          if (input$reference_choice == "Custom") {
            ref_upload <- input$upload_reference
            ext <- tools::file_ext(ref_upload$datapath)

            req(ref_upload)
            validate(need(ext == "csv", "Please upload a csv file"))

            reference <- ref_upload$datapath
          } else {
            reference <- "app_reference"
          }

          #process multi-query upload for eventual download
          user_multi_query_upload <- process_multi_query(file_upload$datapath,
                                                         include_amel = input$count_amel_multi,
                                                         reference = reference,
                                                         scoring_algorithm = sub("_.*", "", input$score_multi),
                                                         masters_denominator = sub(".*_", "", input$score_multi))

          save_multi_query_workbook(user_multi_query_upload, file)

        }
      )

      # only enables download results if file has first been uploaded
      multi_query_present <- reactive(!is.null(input$upload_multi))
      observe({
        if (multi_query_present()) {
          shinyjs::enable("download_processed_data")
        } else {
          shinyjs::disable("download_processed_data")
        }
      })

      # sample csv download
      output$download_template_multi <- downloadHandler(
        filename = "multi_query_blank_template.csv",

        content = function(file) {
          write.csv(read.csv("./data/multi_query_blank_template.csv"), file, row.names = FALSE)
        }
      )
    }
  )
}
