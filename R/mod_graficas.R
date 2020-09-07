#' graficas UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_graficas_ui <- function(id){
  ns <- NS(id)
  
  tabsetPanel(
    tabPanel(title = 'Gráficas por Totales',
             selectInput(inputId = 'tipo_grafica', label = 'Datos a Graficar', choices = ''),
             fluidRow(column(9,
                             radioButtons(inputId = 'tiempo_grafica' , label = 'Temporalidad a Graficar', inline = TRUE,
                                          choices = c('Por Mes' , 'Por Día') , selected = 'Por Mes')),
                      column(2, offset = 1,
                             actionButton(inputId = 'boton_zoom_grafica' , label = NULL , icon = icon('search-plus'),
                                          style = 'font-size:150%'))),
             shinycssloaders::withSpinner(plotOutput(outputId = 'grafica_sp', height = '350px',
                                                     click = clickOpts(id = 'plot_click')),
                                          type = 3 , color = '#00A65A' , size = 1 , color.background = '#FFFFFF'),
             uiOutput(outputId = 'click_info'),
             tags$div(id = 'div_grafica_a'),
             tags$div(tableOutput(outputId = 'tabla_totales'),
                      style = 'font-size: 80%; width: 100%; margin: auto;')),
    tabPanel(title = 'Gráficas por Día y Hora',
             selectInput(inputId = 'tipo_grafica2', label = 'Datos a Graficar', choices = ''),
             fluidRow(column(9,
                             radioButtons(inputId = 'tiempo_grafica2' , label = 'Temporalidad a Graficar', inline = TRUE,
                                          choices = c('Todo el Día' , 'Mañana (6AM - 12PM)' , 'Tarde (1PM - 9PM)' , 'Noche (10PM - 5AM)') , selected = 'Todo el Día')),
                      column(2, offset = 1,
                             actionButton(inputId = 'boton_zoom_grafica2' , label = NULL , icon = icon('search-plus'),
                                          style = 'font-size:150%'))),
             shinycssloaders::withSpinner(plotOutput(outputId = 'grafica_sp2', height = '350px',
                                                     click = clickOpts(id = 'plot_click2')),
                                          type = 3 , color = '#00A65A' , size = 1 , color.background = '#FFFFFF'),
             uiOutput(outputId = 'click_info2'),
             tags$div(id = 'div_grafica_a2'),
             fluidRow(column(1 , actionButton(inputId = 'pastel_left' , icon = icon('angle-left') , label = NULL)),
                      column(10 , textInput(inputId = 'pastel_texto' , label = NULL , value = '')),
                      column(1 , actionButton(inputId = 'pastel_right' , icon = icon('angle-right') , label = NULL))),
             plotOutput(outputId = 'grafica_pastel' , height = '50px'))
  )
  
}
    
#' graficas Server Function
#'
#' @noRd 
mod_graficas_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_graficas_ui("graficas_ui_1")
    
## To be copied in the server
# callModule(mod_graficas_server, "graficas_ui_1")
 
