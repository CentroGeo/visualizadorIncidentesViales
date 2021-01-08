#' graficas UI Function
#'
#' UI function that produces the graphic interface to select the type of plots
#' and the interval to generate them.
#'
#'
#' @param id  shiny parameter for the different sessions
#'
#'
#' @importFrom shiny NS tagList
#'
#'

mod_graficas_ui <- function(id) {
  ns <- NS(id)
  # Type of plot
  Mes_dia <- c("Mensual", "Diaria")
  # Interval of the day
  intervalos <- c("Todo el Día", "Mañana (6AM - 12PM)",
                  "Tarde (1PM - 9PM)", "Noche (10PM - 5AM)")
  # This vector is use to select
  choices_po <- c("Todas", "FGJ", "SSC", "C5", "AXA")
  ## the data and is updated in the server function   #print(ns("fuentes_graf"))
  tabsetPanel(
    ### Graph by month
    tabPanel(title = "Gráficas de conteos",
             selectInput(inputId = ns("Datos_grafica"),
                         label = "Base de Datos",
                         choices = choices_po,
                         selected = "Todas"
                         ),
             fluidRow(column(9,
                        radioButtons(inputId = ns("tiempo_grafica"),
                                    label = "Agregación de los datos",
                                    inline = TRUE,
                                    choices = Mes_dia,
                                    selected = "Mensual"
                                    )
                      )
                      # column(2, offset = 1,
                      #        actionButton(
                      #                     inputId = ns("boton_zoom_grafica"),  # Name to reference in the input
                      #                     label = NULL , 
                      #                     icon = icon("search-plus"),
                      #                     style = "font-size:150%")
                      #        )
                      ),
        shinycssloaders::withSpinner(
                    plotOutput(outputId = ns("grafica_sp"), ## Name to reference in the input
                                height = "350px",
                                click = clickOpts(id = ns("plot_click"))
                                ),
                    type = 3 ,
                    color = "#00A65A",
                    size = 1,
                    color.background = "#FFFFFF"
        ),
        uiOutput(outputId = ns("click_info")),
        tags$div(id = "div_grafica_a"),
        tags$div(tableOutput(outputId = ns("tabla_totales")),
                style = "font-size: 80%; width: 100%; margin: auto;")
        ),
    tabPanel(### Graph by day of the week and time
             title = "Agregados por día de la semana",
             selectInput(inputId = ns("tipo_grafica2"),
                         label = "Datos a Graficar",
                         choices = choices_po,
                         selected = "Todas"),
            #  fluidRow(
            #           column(9,
            #               radioButtons(
            #                       inputId = ns("tiempo_grafica2"),
            #                       label = "Temporalidad a Graficar",
            #                       inline = TRUE,
            #                       choices = intervalos,
            #                       selected = "Todo el Día"
            #                       )
            #           )#,
            #           # column(2, 
            #           #        offset = 1,
            #           #        actionButton(inputId = ns('boton_zoom_grafica2'), # Name to reference the type of graphic
            #           #                     label = NULL , 
            #           #                     icon = icon('search-plus'),
            #           #                     style = 'font-size:150%')
            #           #        )
            #            ),
             shinycssloaders::withSpinner(
                                    plotOutput(outputId = ns("grafica_horas"),
                                               height = "350px",
                                               click = clickOpts(
                                                 id = "plot_click2")
                                               ),
                                    type = 3,
                                    color = "#00A65A",
                                    size = 1,
                                    color.background = "#FFFFFF"
                    )#,
             #plotOutput(outputId = ns("grafica_pastel"), height = "50px")
             )
  )
}




#' Graficas Mes Dia Function
#'
#' Generates the graph of the "Incidentes viales" by month or daily
#'
#'
#'@param input shiny parameter where the inputs from the UI are store
#'and the month or day graph is selected
#'
#'@param dataframe_rec_in The reactive function that returns a dataframe
#'
#'@returns The render plot selected in the UI
mes_dia_graf <- function(dataframe_rec_in, input) {
  # renderPlot({
  renderCachedPlot({
    if (input$tiempo_grafica == "Mensual") {
      ############## Mensual####################
      datos <- dataframe_rec_in()
      ########### Agrupar###################
      if (input$Datos_grafica != "Todas") {
        datos <- datos[datos$fuente == input$Datos_grafica, ]
      }
      count_months_year <- dplyr::count(datos,
                   lubridate::month(datos$timestamp),
                   lubridate::year(datos$timestamp),
                   fuente)
      names(count_months_year) <- c("month", "year",
                                    "fuente", "n", "geometry")
      count_months_year$month_year <- lubridate::as_date(
                                                  paste0("1/",
                                                    count_months_year$month,
                                                    "/",
                                                    count_months_year$year),
                                                  format = "%d/%m/%Y"
                                      )
      count_months_year$fuente <- as.factor(
              count_months_year$fuente
            )
      ############### Grafica
      if (length(unique(datos$fuente)) != 1) {
        p <- ggplot2::ggplot(
              data = count_months_year,
              ggplot2::aes(x = month_year,
                y = n,
                group = fuente,
                colour = fuente
              )
            )
      }
      else if (length(unique(datos$fuente)) == 0) {
        p <- ggplot2::ggplot()
      }
      else{
        p <- ggplot2::ggplot(
          data = count_months_year,
          ggplot2::aes(x = month_year, y = n, group = 1, colour = fuente)
        )
      }

      paleta_colores <- c(FGJ = "#952800",
                          SSC = "#043A5F",
                          C5 =  "#956F00",
                          AXA = "#5E0061")
      p <- p +
          ggplot2::geom_line() +

          #ggplot2::scale_x_date(breaks = "1 month") +
          ggplot2::scale_x_date(
            minor_breaks = function(x) seq.Date(from = min(x),
            to = max(x),
            by = "1 month")
          ) +
          ggplot2::labs(
            x = "Mes",
            y = "Número de Incidentes",
            title = "Número de Incidentes por Mes"
          ) +
          ggplot2::theme(
            axis.text.x = ggplot2::element_text(
                            angle = 45,
                            vjust = 0.5
                          )
          ) +
          ggplot2::scale_colour_manual(values = paleta_colores,
            limits = unique(count_months_year$fuente),
            name = "Fuente"
          )
    }
    else if (input$tiempo_grafica == "Diaria") {
      ############## Por DIA####################
      datos <- dataframe_rec_in()
      if (input$Datos_grafica != "Todas") {
        datos <- datos[datos$fuente == input$Datos_grafica, ]
      }
      ########### Agrupar###################
      count_months_year <- dplyr::count(datos,
                   lubridate::day(datos$timestamp),
                   lubridate::month(datos$timestamp),
                   lubridate::year(datos$timestamp),
                   fuente)
      names(count_months_year) <- c("day", "month", "year",
                                    "fuente", "n", "geometry")
      count_months_year$dmy <- lubridate::as_date(
                                                  paste0(count_months_year$day,
                                                    "/",
                                                    count_months_year$month,
                                                    "/",
                                                    count_months_year$year),
                                                  format = "%d/%m/%Y"
                                      )
      count_months_year$fuente <- as.factor(count_months_year$fuente)
      ##########Grafica
      if (length(unique(datos$fuente)) != 1) {
        p <- ggplot2::ggplot(
                      data = count_months_year,
                      ggplot2::aes(x = dmy, y = n, 
                        group = fuente, colour = fuente
                      )
            )
      }
      else if (length(unique(datos$fuente)) == 0) {
        p <- ggplot2::ggplot()
      }
      else{
        p <- ggplot2::ggplot(
          data = count_months_year,
          ggplot2::aes(x = dmy, y = n, group = 1, colour = fuente)
        )
      }
      paleta_colores <- c(FGJ = "#952800",
                          SSC = "#043A5F",
                          C5 =  "#956F00",
                          AXA = "#5E0061")
      p <- p +
          ggplot2::geom_line() +
          ggplot2::geom_smooth(
                method = "loess"
          ) +
         #ggplot2::scale_x_date(breaks = "2 week") +
         ggplot2::scale_x_date(minor_breaks =
            function(x) seq.Date(from = min(x),
                                  to = max(x),
                                  by = "2 weeks")
                              ) +
         ggplot2::labs(
                x = "Dia",
                y = "Número de Incidentes",
                title = "Número de Incidentes por Día"
          ) +
          ggplot2::theme(
                axis.text.x = ggplot2::element_text(
                    angle = 45,
                    vjust = 0.5
                )
          ) +
          ggplot2::scale_colour_manual(values = paleta_colores,
                                     limits = unique(count_months_year$fuente),
                                     name = "Fuente"
          )

    }
    return(p)
  },
  cacheKeyExpr =  list(input$Datos_grafica,
                       input$tiempo_grafica,
                       dataframe_rec_in()
                       ),
  cache = diskCache(
            dir= cache_dir_o,
            max_size = 20 * 1024^2
          )
  )
}

#' Grafica Horas Function
#'
#' Generates the graph of the "Incidentes viales" by the selected interval day
#'
#'@param input shiny parameter where the inputs from the UI are store
#'and the month or day graph is selected
#'
#'@param dataframe_rec_in The reactive function that returns a dataframe with
#'the "incidentes viales"
#'
#'@returns The render plot selected in the UI
horas_graf <- function(dataframe_rec_in, input) {
  # renderPlot({
  cache_dir_o <- getOption("Cache_dir", default = "./cache_dir")
  print(cache_dir_o)
  renderCachedPlot({
    datos <- dataframe_rec_in()
    if(nrow(datos)==0){
      ## Grafica vacia 
      p <- ggplot2::ggplot()
      p <- p+ ggplot2::labs(x = "Dia") +
        ggplot2::labs(y = "Hora")
      return(p)
    }
    colores_fgj <- list(start = "#ffffcc", end = "#b10026")
    colores_ssc <- list(start = "#fff7fb", end = "#034e7b")
    colores_c5 <-  list(start = "#ffffe5", end = "#8c2d04")
    colores_axa <- list(start = "#fff7f3", end = "#7a0177")
    colores_todas <- list(start = "#fff5f0", end = "#99000d")
    paleta <- list(
      colores_fgj = colores_fgj,
      colores_ssc = colores_ssc,
      colores_c5 = colores_c5,
      colores_axa = colores_axa,
      colores_todas = colores_todas
    )
    if (input$tipo_grafica2 == "FGJ") {
      colores <- paleta$colores_fgj
    }else if (input$tipo_grafica2 == "AXA") {
      colores <- paleta$colores_axa
    }else if (input$tipo_grafica2 == "C5") {
      colores <- paleta$colores_c5
    }else if (input$tipo_grafica2 == "SSC") {
      colores <- paleta$colores_ssc
    }else{
      colores <- paleta$colores_todas
    }
    cuentas <- dplyr::count(
      datos,
      lubridate::wday(timestamp),
      lubridate::hour(timestamp)
    )
    names(cuentas) <- c("Dia", "hora", "Incidentes", "geometry")
    cuentas$Dia <- as.character(cuentas$Dia)
    day_labels <- c(
      "1" = "Domingo", "2" = "Lunes", "3" = "Martes",
      "4" = "Miércoles",
      "5" = "Jueves", "6" = "Viernes", "7" = "Sábado"
    )
    cuentas <- tidyr::drop_na(cuentas)
    cuentas <- dplyr::mutate(cuentas, Hora = sprintf("%02d:00", hora))
    cuentas$Dia <- factor( cuentas$Dia, levels = c("2","3","4","5","6","7","1"))
    p <- ggplot2::ggplot(
          cuentas,
          ggplot2::aes(x = Dia,
                    y = Hora, 
                    fill = Incidentes
                   )
          ) +
    ggplot2::geom_tile() +
    ggplot2::scale_x_discrete(labels = day_labels) +
    ggplot2::scale_fill_gradient(low = colores$start, high = colores$end) +
    ggplot2::theme_bw() +
    ggplot2::theme(axis.line = ggplot2::element_blank(),
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank()
    )
    return(p)
  },
  cacheKeyExpr =  list(input$tipo_grafica2,
                       dataframe_rec_in()
                      ),
  cache = diskCache(
                  dir = cache_dir_o,
                  max_size = 20 * 1024^2
                  )
  )
}
#' graficas Server Function
#'
#' The function use as parameter the reactive function that returns a dataframe
#' from the mod_DBSelector module, and the shiny input parameter to
#' create the plots.
#' These are put into the corresponding outputs for the UI reference in the
#'
#' @param input shiny Parameter where the inputs from the UI are store
#'
#' @param output shiny parameter where the id are reference
#' to display in the UI
#'
#' @param session shiny parameter to store the session
#'
#' @param dataframe_rec  The reactive function that returns a dataframe
#'
mod_graficas_server <- function(input, output, session, dataframe_rec) {
  ns <- session$ns
  observeEvent(dataframe_rec(), ignoreNULL = FALSE, {
    data_f <- dataframe_rec()
    val_fue <- unique(data_f$fuente)
    val_fue <- append(val_fue, "Todas")
    opciones <- as.character(val_fue)
    updateSelectInput(session, inputId = "Datos_grafica",
                      label = "Datos a Graficar",
                      choices = opciones,
                      selected = "Todas"
                      )
    updateSelectInput(session, inputId = "tipo_grafica2",
                      label = "Datos a Graficar",
                      choices = opciones,
                      selected = "Todas"
    )
  })
  output$grafica_sp <- mes_dia_graf(dataframe_rec, input)
  output$grafica_horas <- horas_graf(dataframe_rec, input)

}
