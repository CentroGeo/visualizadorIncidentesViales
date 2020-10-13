#' landingPageUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_landingPageUI_ui <- function(id){
  ns <- NS(id)
  tagList(
    
  )
}

#' landingPageUI Server Function
#'
#' @noRd 
mod_landingPageUI_server <- function(input, output, session){
  ns <- session$ns
  
}

## To be copied in the UI
# mod_landingPageUI_ui("landingPageUI_ui_1")

## To be copied in the server
# callModule(mod_landingPageUI_server, "landingPageUI_ui_1")

