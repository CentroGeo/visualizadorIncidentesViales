#' csvFileUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_csvFileUI_ui <- function(id, label = "CSV file"){
  ns <- NS(id)
  tagList(
    tagList(
      fileInput(ns("file"), label),
      checkboxInput(ns("heading"), "Has heading", value=TRUE),
      selectInput(ns("quote"), "Quote", c(
        "Double quote" = "\"",
        "Single quote" = "'",
        "None" = ""
        
      )
      ),
      selectInput(ns("separator"), "Separator", c(
        "Comma" = ",",
        "Semmicolon" = ";"
      )
      ),
      selectInput(ns("encoding"), "Encoding", c(
        "UTF-8" = "UTF-8",
        "Latin-1" = "latin1"
      ))
    )
  )
}
    
#' csvFileUI Server Function
#'
#' @noRd 
mod_csvFileUI_server <- function(input, output, session){
  ns <- session$ns
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })
  
  # The user's data, parsed into a data frame
  dataframe <- reactive({
    df <- readr::read_delim(userFile()$datapath,
             col_names = input$heading,
             quote = input$quote,
             delim = input$separator
             )

    preprocesa_pgj(df)
  })
  
  # We can run observers in here if we want to
  observe({
    msg <- sprintf("File %s was uploaded", userFile()$name)
    cat(msg, "\n")
  })
  # Return the reactive that yields the data frame
  return(dataframe)
 
}
    
## To be copied in the UI
# mod_csvFileUI_ui("csvFileUI_ui_1")
    
## To be copied in the server
# callModule(mod_csvFileUI_server, "csvFileUI_ui_1")
 
