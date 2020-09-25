#' graficas UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' 
#' 



mod_graficas_ui <- function(id){
  ns <- NS(id)
  
  Mes_dia<- c("Por Mes" , "Por Día")
  intervalos <- c("Todo el Día" , "Mañana (6AM - 12PM)" ,
                  "Tarde (1PM - 9PM)" , "Noche (10PM - 5AM)")
  choices_po <- c("Combinadas", "FGJ", "SSC", "AXA") ### Este vector deveria ser reactivo y poder cambiar
  
  tabsetPanel(
    tabPanel(title = "Gráficas por Totales",
             selectInput(inputId = ns("Datos_grafica"),
                         label = "Datos a Graficar",
                         choices = choices_po, ### Falta arreglar que esto sea interactivo
                         selected = "Combinadas"
                         ),
             fluidRow(column(9,
                             radioButtons(inputId = ns("tiempo_grafica") , 
                                          label = "Temporalidad a Graficar", 
                                          inline = TRUE,
                                          choices = Mes_dia , 
                                          selected = "Por Mes"
                                          )
                             ),
                      column(2, offset = 1,
                             actionButton(inputId = ns("boton_zoom_grafica"),
                                          label = NULL ,
                                          icon = icon("search-plus"),
                                          style = "font-size:150%")
                             )
                      ),
             shinycssloaders::withSpinner(
                                  plotOutput(outputId = ns("grafica_sp"),
                                             height = "350px",
                                             click = clickOpts(id = ns("plot_click"))
                                             ),
                                  type = 3 ,
                                  color = '#00A65A' ,
                                  size = 1 , 
                                  color.background = '#FFFFFF'
                            ),
             uiOutput(outputId = ns("click_info")),
             tags$div(id = "div_grafica_a"),
             tags$div(tableOutput(outputId = ns("tabla_totales")),
                      style = "font-size: 80%; width: 100%; margin: auto;")
             ),
    tabPanel(title = "Gráficas por Día y Hora",
             selectInput(inputId = ns("tipo_grafica2"), 
                         label = "Datos a Graficar",
                         choices = choices_po
                         ),
             fluidRow(
                      column(9,
                          radioButtons(
                                  inputId = ns('tiempo_grafica2'),
                                  label = 'Temporalidad a Graficar',
                                  inline = TRUE,
                                  choices = intervalos ,
                                  selected = 'Todo el Día'
                                  )
                      ),
                      column(2, 
                             offset = 1,
                             actionButton(inputId = ns('boton_zoom_grafica2'),
                                          label = NULL ,
                                          icon = icon('search-plus'),
                                          style = 'font-size:150%')
                             )
                      ),
             shinycssloaders::withSpinner(
                                    plotOutput(outputId = ns('grafica_sp2'),
                                               height = '350px',
                                               click = clickOpts(id = 'plot_click2')
                                               ),
                                    type = 3 ,
                                    color = '#00A65A' ,
                                    size = 1 ,
                                    color.background = '#FFFFFF'
                    ),
             uiOutput(outputId = 'click_info2'),
             tags$div(id = 'div_grafica_a2'),
             fluidRow(column(1 ,
                             actionButton(inputId = ns('pastel_left'),
                                          icon = icon('angle-left') ,
                                          label = NULL)
                             ),
                      column(10 ,
                             textInput(inputId = ns('pastel_texto'),
                                       label = NULL , 
                                       value = '')
                             ),
                      column(1 ,
                             actionButton(inputId = ns('pastel_right') ,
                                          icon = icon('angle-right'),
                                          label = NULL)
                             )
                      ),
             plotOutput(outputId = ns('grafica_pastel') , height = '50px'))
  )
  
}
    
#' graficas Server Function
#'
#' @noRd 

  
mes_dia_graf <- function(dataframe_rec_in ,input){
  renderPlot({
    print(input$tiempo_grafica)
    if(input$tiempo_grafica =="Por Mes"){
      ############## Por Mes####################
      data <- dataframe_rec_in()
      # print(names(data))
      count_months_year<- dplyr::count(
        data,
        paste0(
          1,
          "/",
          month(data$timestamp),
          '/',
          year(data$timestamp),
          fuente
        )
      )
      names(count_months_year)<- c("month_year_fue","n", "geometry")
      
      count_months_year$month_year<- substr(
        count_months_year$month_year_fue,
        1,
        nchar(count_months_year$month_year_fue)- 3 
      ) 
      count_months_year$fuente<- substr(
        count_months_year$month_year_fue,
        nchar(count_months_year$month_year_fue)- 3 +1,
        nchar(count_months_year$month_year_fue) 
      )
      count_months_year$month_year<- lubridate::as_date(
                                                  count_months_year$month_year,
                                                  format="%d/%m/%y"
                                      )
      if(length(unique(data$fuente))!= 1 ){
        p<- ggplot2::ggplot(
              data = count_months_year,
              aes(x=month_year, y=n, group = fuente) 
            )  
            
        
      }
      else if(length(unique(data$fuente))== 0){
        p<- ggplot2::ggplot() 
          
      }
      else{
        p<- ggplot2::ggplot(
          data = count_months_year,
          aes(x=month_year, y=n, group = 1) 
        )
        
      }
      p <- p + 
          ggplot2::geom_line() +
          ggplot2::scale_x_date(breaks = "1 month") +
          ggplot2::labs(
                      x = 'Mes',
                      y = 'Número de Incidentes',
                      title = 'Número de Incidentes por Mes'
          ) +
          ggplot2::theme(
                      axis.text.x = element_text(
                                      angle = 45,
                                      vjust = 0.5
                                    )
          )
    }
    else if(input$tiempo_grafica =="Por Día"){
      ############## Por Mes####################
      data <- dataframe_rec_in()
      count_months_year<- dplyr::count(
        data,
        paste0(day(data$timestamp),
              "/", 
              month(data$timestamp),
              "/",
              year(data$timestamp),
              fuente
        )
        
      )
      names(count_months_year)<- c("dmy_fue","n", "geometry")
      count_months_year$dmy<- substr(
        count_months_year$dmy_fue,
        1,
        nchar(count_months_year$dmy_fue)- 3 
      ) 
      count_months_year$fuente<- substr(
        count_months_year$dmy_fue,
        nchar(count_months_year$dmy_fue)- 3 +1,
        nchar(count_months_year$dmy_fue) 
      )
      count_months_year$dmy <- lubridate::as_date(
                                    count_months_year$dmy,
                                    format= "%d/%m/%Y"
                                ) 
      if(length(unique(data$fuente))!= 1 ){
        p<- ggplot2::ggplot(
                      data = count_months_year,
                      aes(x=dmy, y=n, group = fuente) 
            )
      }
      else if(length(unique(data$fuente))== 0){
        p<- ggplot2::ggplot()
      }
      else{
        p <- ggplot2::ggplot(
          data = count_months_year,
          aes(x=dmy, y=n, group = 1) 
        )
      } 
      p<- p +
          ggplot2::geom_line() +
          ggplot2::geom_smooth(
                method = "loess"
          ) +
          ggplot2::scale_x_date(breaks = "1 week") +
          ggplot2::labs(
                x = 'Dia',
                y = "Número de Incidentes",
                title = "Número de Incidentes por Día"
          ) +
          ggplot2::theme(
                axis.text.x = element_text(
                    angle = 45,
                    vjust = 0.5
                )
          )
    }
    print(p)
    return(p)
  })
}

select_mes_dia <- function(input , data_frame_reac){
  reactivePlot({
    print(input$tiempo_grafica)
    plo<-mes_año_graf(data_frame_reac)
    plo
    })
  
}

mod_graficas_server <- function(input, output, session, dataframe_rec){
  ns <- session$ns
  output$grafica_sp <- mes_dia_graf(dataframe_rec,input)
}
#   observeEvent(c(dataframe_rec() ),
#   { 
#     data_frame_sel <- dataframe_rec()
#     if(input$Datos_grafica!= "Combinadas"){
#       data_all<- data_frame_sel[data_frame_sel$fuente == input$Datos_grafica,]
#       interval_max <-max(data_all$timestamp )
#       interval_min <-min(data_all$timestamp )
#       
#       # if (input$tiempo_grafica == 'Por Mes' ) {
#       #   style <- paste0("position:absolute; z-index:100; background-color: rgba(205, 205, 205, 0.80); ",
#       #                   "left:",
#       #                   left_px + 10,
#       #                   "px; top:", 
#       #                   top_px - 40,
#       #                   "px; padding: 5px 10px 0px; border-radius: 10px;"
#       #                   )
#       # }
#       # else {
#       #   style <- paste0("position:absolute; z-index:100; background-color: rgba(205, 205, 205, 0.80); ",
#       #                   "left:", 
#       #                   left_px + 10,
#       #                   "px; top:",
#       #                   top_px - 40,
#       #                   "px;padding: 5px 10px 0px; border-radius: 10px; font-size: 125%;"
#       #                   ) 
#       # }
#     }
#     else{
#       
#       data_FGJ<- data_frame_sel[data_frame_sel$fuente =="FGJ",]
#       data_SSC<- data_frame_sel[data_frame_sel$fuente =="SCC",]
#       data_AXA<- data_frame_sel[data_frame_sel$fuente =="AXA",]
#       
#     } 
#      
# 
#             
#   })
#   
#   output$grafica_sp ####
# 
# }
    
