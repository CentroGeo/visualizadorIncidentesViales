#' DBSelector UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_DBSelector_ui <- function(id){
  ns <- NS(id)
  shinydashboard::box(width = 12 ,
                      tags$p('Filtros de Incidentes',
                             style = 'font-size: 16pt;'),
                      selectInput(inputId = 'filtro_lugar' , label = 'Área de Análisis',
                                  choices = c('Total Ciudad de México' , 'Álvaro Obregón' , 'Azcapotzalco' , 'Benito Juárez' , 'Coyoacán',
                                              'Cuajimalpa de Morelos' , 'Cuauhtémoc' , 'Gustavo A. Madero' ,
                                              'Iztacalco' , 'Iztapalapa' , 'La Magdalena Contreras' , 'Miguel Hidalgo',
                                              'Milpa Alta' , 'Tlalpan' , 'Tláhuac' , 'Venustiano Carranza', 'Xochimilco')),
                      fluidRow(column(6,
                                      radioButtons(inputId = 'filtro_incidente' , label = 'Tipo de Incidente' , inline = TRUE,
                                                   choices = c('Decesos' , 'Lesionados' , 'Accidentes' , 'Todos')),
                                      checkboxGroupInput(inputId = 'filtro_bd' , label = 'Base de Datos' , inline = TRUE,
                                                         choices = c('PGJ' , 'SSC' , 'C5' , 'AXA' , 'Repubikla'))),
                               column(6)
                      ))
}
    
#' DBSelector Server Function
#'
#' @noRd 
mod_DBSelector_server <- function(input, output, session){
  ns <- session$ns
  
 
}
    
## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")
    
## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
 
