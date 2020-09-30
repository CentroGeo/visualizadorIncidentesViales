#' bar UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_bar_ui <- function(id){
  ns <- NS(id)
  fluidRow(
    sliderInput(inputId = ns('filtro_fecha') ,
                label = 'Periodo de Tiempo' ,
                width = '100%',
                timeFormat = '%d/%m/%Y',
                min = as.Date("2015-01-01","%Y-%m-%d"),
                max = as.Date("2019-12-31","%Y-%m-%d"),
                value = c(as.Date('2018-01-01',"%Y-%m-%d") , as.Date('2019-12-31',"%Y-%m-%d"))
                )
  )
}
    
#' bar Server Function
#'
#' @noRd 
mod_bar_server <- function(input, output, session){
  ns <- session$ns
  interval_val <- reactive({
    input$filtro_fecha
  })
  return(interval_val)
}
    
## To be copied in the UI
# mod_bar_ui("bar_ui_1")
    
## To be copied in the server
# callModule(mod_bar_server, "bar_ui_1")
 
