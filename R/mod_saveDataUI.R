#' saveDataUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_saveDataUI_ui <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(ns("save"), "Guardar")
  )
}
    
#' saveDataUI Server Function
#'
#' @noRd 
mod_saveDataUI_server <- function(input, output, session, datos){
  ns <- session$ns
  observeEvent(input$save, {
    print(head(datos()))
    # cat("CACA")
    # session$sendCustomMessage(type = 'testmessage',
    #                           message = 'Thank you for clicking')
  })
}
    
## To be copied in the UI
# mod_saveDataUI_ui("saveDataUI_ui_1")
    
## To be copied in the server
# callModule(mod_saveDataUI_server, "saveDataUI_ui_1")
 
