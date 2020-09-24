#' Elemento de interfase para subir csvs las fuentes de datos
#'
#' @description Interfase para subir, procesar y actualizar las fuentes de datos que se utilizan
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_csvFileUI_ui <- function(id, label = "Selecciona el archivo") {
  ns <- NS(id)

  tagList(
    fileInput(ns("file"), label),
    selectInput(ns("encoding"), "Codificación", c(
      "UTF-8" = "UTF-8",
      "Latin-1" = "latin1"
    )),
    selectInput(ns("database"), "Fuente de Datos", c(
      "Fiscalía" = "fgj",
      "Seguridad Ciudadana" = "ssc",
      "AXA" = "axa"
    )),
    actionButton(ns("save"), "Guardar")
  )
}

#' csvFileUI Server Function
#'
#' @noRd
mod_csvFileUI_server <- function(input, output, session) {
  ns <- session$ns
  shinyjs::toggleState("save")
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })

  # The user's data, parsed into a data frame
  dataframe <- reactive({
    if (input$database == "fgj") {
      df <- readr::read_delim(userFile()$datapath,
        col_names = TRUE,
        quote = "\"",
        delim = ","
      )
      validate(need(try(preprocesa_pgj(df)), "El archivo no es de la FGJ"))
      shinyjs::toggleState("save")
      df <- preprocesa_pgj(df)
    } else if (input$database == "ssc") {
      df <- readr::read_delim(userFile()$datapath,
        col_names = TRUE,
        quote = "\"",
        delim = ",",
        col_types = list(
          "No. FOLIO" = readr::col_character(),
          "HORA_EVENTO" = readr::col_character()
        )
      )
      validate(need(try(preprocesa_ssc(df)), "El archivo no es de la SSC"))
      shinyjs::toggleState("save")
      df <- preprocesa_ssc(df)
    } else if (input$database == "axa") {
      df <- readr::read_delim(userFile()$datapath,
        col_names = TRUE,
        quote = "\"",
        delim = ";"
      )
      validate(need(try(preprocesa_axa(df)), "El archivo no es de AXA"))
      shinyjs::toggleState("save")
      df <- preprocesa_axa(df)
    }
  })

  # We can run observers in here if we want to
  observe({
    msg <- sprintf("File %s was uploaded", userFile()$name)
    cat(msg, "\n")
  })

  observeEvent(input$save, {
    f_name <- paste0(input$database, ".rds")
    saveRDS(dataframe(), file = paste0("data-raw/", f_name))
    shinyjs::toggleState("save")
    showNotification("Datos guardados", type = "message")
  })
  # Return the reactive that yields the data frame
  return(dataframe)
}

## To be copied in the UI
# mod_csvFileUI_ui("csvFileUI_ui_1")

## To be copied in the server
# callModule(mod_csvFileUI_server, "csvFileUI_ui_1")
