# app modules
#-----------------------------------------global UI options------------------------------------------
options(spinner.type = 1, spinner.color = "#232a30", spinner.size = 2)


#-------------------------------------------UI-----------------------------------------------------

# margin-left: auto; margin-right: auto; for centering all textInputs
myModuleUI <- function(id) {
  ns <- NS(id)

  fluidPage(
    fluidRow(style = "background-color:#f5f5f5; max-width: 800px; margin-left:
             auto; margin-right: auto; border-style: solid; border-color: #e8e8e8",
      column(width = 4, align="center",
        textInput(
          inputId = ns("amel"),
          label = "Amel",
          width = "150px"
          # placeholder = "X",
        ),
        textInput(
          inputId = ns("csf1po"),
          label = "CSF1PO",
          width = "150px"
        ),
        textInput(
          inputId = ns("d10s1248"),
          label = "D10S1248",
          width = "150px"
        ),
        textInput(
          inputId = ns("d12s391"),
          label = "D12S391",
          width = "150px"
        ),
        textInput(
          inputId = ns("d13s317"),
          label = "D13s317",
          width = "150px"
        ),
        textInput(
          inputId = ns("d16s539"),
          label = "D16s539",
          width = "150px"
        ),
        textInput(
          inputId = ns("d18s51"),
          label = "D18s51",
          width = "150px"
        ),
        textInput(
          inputId = ns("d19s433"),
          label = "D19S433",
          width = "150px"
        )
      ),
      column(width = 4, align="center",
        textInput(
          inputId = ns("d1s1656"),
          label = "D1S1656",
          width = "150px"
        ),
        textInput(
          inputId = ns("d21s11"),
          label = "D21s11",
          width = "150px"
        ),
        textInput(
          inputId = ns("d22s1045"),
          label = "D22S1045",
          width = "150px"
        ),
        textInput(
          inputId = ns("d2s1338"),
          label = "D2S1338",
          width = "150px"
        ),
        textInput(
          inputId = ns("d2s441"),
          label = "D2S441",
          width = "150px"
        ),
        textInput(
          inputId = ns("d3s1358"),
          label = "D3s1358",
          width = "150px"
        ),
        textInput(
          inputId = ns("d5s818"),
          label = "D5s818",
          width = "150px"
        ),
        textInput(
          inputId = ns("d7s820"),
          label = "D7s820",
          width = "150px"
        )
      ),
      column(width = 4, align="center",
        textInput(
          inputId = ns("d8s1179"),
          label = "D8s1179",
          width = "150px"
        ),
        textInput(
          inputId = ns("dys391"),
          label = "DYS391",
          width = "150px"
        ),
        textInput(
          inputId = ns("fga"),
          label = "FGA",
          width = "150px"
        ),
        textInput(
          inputId = ns("penta.d"),
          label = "Penta.D",
          width = "150px"
        ),
        textInput(
          inputId = ns("penta.e"),
          label = "Penta.E",
          width = "150px"
        ),
        textInput(
          inputId = ns("th01"),
          label = "TH01",
          width = "150px"
        ),
        textInput(
          inputId = ns("tpox"),
          label = "TPOX",
          width = "150px"
        ),
        textInput(
          inputId = ns("vwa"),
          label = "vWA",
          width = "150px"
        ),
      ),
    ),
    br(),
    fluidRow(style = "background-color:#f5f5f5; max-width: 800px; margin-left:
             auto; margin-right: auto; border-style: solid; border-color: #e8e8e8",
             column(width = 6,
                    br(),
                    # actionButton(
                    #   inputId = ns("go"),
                    #   label = "Search",
                    #   icon("dna"),
                    #   style = "color: #ededed; background-color: #232a30",
                    #   width = "100px"
                    # ),
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
                    fileInput(
                      inputId = ns("upload"),
                      label = "Optionally, upload CSV file of single-query data",
                      multiple = FALSE, #TODO: will enable this once I move on to multi-query entries phase
                      accept = ".csv", #TODO: headers must be present in file. Need to add file validator
                      width = "400px"
                    ),
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


#-------------------------------------------SERVER-----------------------------------------------------

## TODO: move score or other relevant data to earlier columns in table below
# for easier visibility
## TODO: query below should be concat of all options
## TODO: provide option to add NA (but NA read as character so convert to NA) and/or keep as it (leave blank)
## ^ use dplyr::na_if ; e.g. na_if("NA, "NA") ; https://dplyr.tidyverse.org/reference/na_if.html

myModuleServer <- function(id, dataset) {
  moduleServer(
    id,
    function(input, output, session) {

      output$filtered_data <- DT::renderDT({

        #-----------------test----------------------
        ## TODO: query_test below is placeholder generated by
        # query_test <- gbmpdx_ref[1,]
        # rownames(query_test) <- "query"
        # DT::datatable(process_query(query = query_test),
        #               rownames = FALSE,
        #               options = list(pageLength = 10,
        #                              scrollX = TRUE),
        #               escape = FALSE) # to not escape HTML code in table
        #-----------------end test----------------------
        # TODO: automate the below - just testing for now
        # https://stackoverflow.com/questions/40044768/addressing-multiple-inputs-in-shiny

        #NOTE: I noticed a strange lock/lag after several submits with eventReactive
        # which is not present when eventReactive is not used. Explore this further
        # update_query <- eventReactive(input$go, {
        #   c(
        #     input$amel,
        #     input$csf1po,
        #     input$d10s1248,
        #     input$d12s391,
        #     input$d13s317,
        #     input$d16s539,
        #     input$d18s51,
        #     input$d19s433,
        #     input$d1s1656,
        #     input$d21s11,
        #     input$d22s1045,
        #     input$d2s1338,
        #     input$d2s441,
        #     input$d3s1358,
        #     input$d5s818,
        #     input$d7s820,
        #     input$d8s1179,
        #     input$dys391,
        #     input$fga,
        #     input$penta.d,
        #     input$penta.e,
        #     input$th01,
        #     input$tpox,
        #     input$vwa
        #   )
        # })

        #browser()

        input_data <-c(
            input$amel,
            input$csf1po,
            input$d10s1248,
            input$d12s391,
            input$d13s317,
            input$d16s539,
            input$d18s51,
            input$d19s433,
            input$d1s1656,
            input$d21s11,
            input$d22s1045,
            input$d2s1338,
            input$d2s441,
            input$d3s1358,
            input$d5s818,
            input$d7s820,
            input$d8s1179,
            input$dys391,
            input$fga,
            input$penta.d,
            input$penta.e,
            input$th01,
            input$tpox,
            input$vwa)


        # create query d.f (order matches marker input)
        user_df <- data.frame(markers_ref, input_data)
        #user_df <- data.frame(markers_ref, update_query())
        user_df <- as.data.frame(t(user_df))
        user_df <- add_header(user_df)

        DT::datatable(process_query(query = user_df,
                                    scoring_algorithm = sub("_.*", "", input$score),
                                    masters_denominator = sub(".*_", "", input$score)),
                      rownames = FALSE,
                      options = list(
                        pageLength = 10,
                        scrollX = TRUE
                      ),
                      escape = FALSE
        ) # to not escape HTML code in table

      })

      output$filtered_data_csv <- DT::renderDT({

        file <- input$upload
        ext <- tools::file_ext(file$datapath)

        req(file)
        validate(need(ext == "csv", "Please upload a csv file"))

        #---------------------#TODO: make function for this pre-processing -------------------
        # process upload to add it to expected format (wider and comma-separated per allele)

        user_query_upload <- read.csv(file$datapath, header = TRUE, colClasses = "character")

        # remove any homozygous values if present
        user_query_upload <- as.data.frame(t(apply(user_query_upload, 1, function(x) replace(x, duplicated(x), NA))))

        # ensuring all still character...

        user_query_upload <- mutate_all(user_query_upload, as.character)

        # unite

        user_query_upload <- tidyr::unite(user_query_upload, STR_data, -GBM, -Marker, remove = TRUE, na.rm = TRUE, sep = ",")

        #------ change layout to wide -----
        user_query_upload <- tidyr::pivot_wider(user_query_upload, names_from = Marker, values_from = STR_data)

        # now re-add NAs for any STRs where there is no data
        user_query_upload[user_query_upload==""] <- NA

        user_query_upload <- as.data.frame(user_query_upload)

        # make first column, row name
        rownames(user_query_upload) <- user_query_upload[,1]
        user_query_upload <- user_query_upload[,-1]

        #------------------------------------end pre-processing ----------------------------

        DT::datatable(process_query(query = as.data.frame(user_query_upload),
                                    scoring_algorithm = sub("_.*", "", input$score),
                                    masters_denominator = sub(".*_", "", input$score)
                                    ),
                      rownames = FALSE,
                      options = list(
                        pageLength = 10,
                        scrollX = TRUE
                      ),
                      escape = FALSE
        )
      })

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
