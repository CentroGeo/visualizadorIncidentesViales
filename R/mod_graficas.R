#' graficas UI Function
#'
#' Función de UI que produce las gráficas y los controles para 
#' seleccionar el tipo de gráfica de acuerdo a los datos seleccionados
#' en DBSelector.
#'
#' @param id  parámetro de shiny para diferentes sesiones
#'
#'
#' @importFrom shiny NS tagList
#'
#'
mod_graficas_ui <- function(id) {
  ns <- NS(id)
  # Tipo de gráfica
  Mes_dia <- c("Mensual", "Diaria")
  # Intervalo del dia
  intervalos <- c("Todo el Día", "Mañana (6AM - 12PM)",
                  "Tarde (1PM - 9PM)", "Noche (10PM - 5AM)")
  # Tipos de base de datos
  choices_po <- c("Todas", "FGJ", "SSC", "C5", "AXA")
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
    tabPanel(# Gráfica por día de la semana y hora
             title = "Agregados por día de la semana",
             selectInput(inputId = ns("tipo_grafica2"),
                         label = "Datos a Graficar",
                         choices = choices_po,
                         selected = "Todas"),
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
                    )
             )
  )
}




#' Función de Gráficas Mes/Dia 
#'
#' Genera las gráficas de "Incidentes viales" por mes o diarias
#'
#'
#'@param input Los valores seleccionados por el usuario en la función UI
#'       input$tiempo_grafica Temporalidad de la gráfica
#'       input$Datos_grafica Qué base de datos fgraficar
#'
#'@param dataframe_rec_in El reactive con los datos seleccionados en DBSelector
#'
#'@returns La gráfica renderizada
mes_dia_graf <- function(dataframe_rec_in, input) {
  renderPlot({
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
      ### Por DIA ###
      datos <- dataframe_rec_in()
      if (input$Datos_grafica != "Todas") {
        datos <- datos[datos$fuente == input$Datos_grafica, ]
      }
      ### Agrupar ###
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
      ### Grafica ###
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
  }
  ) %>%
  # Esto lo liga al cache (shiny >= 1.6)
  bindCache(input$Datos_grafica, input$tiempo_grafica, dataframe_rec_in())
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
  renderPlot({
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
  }
  ) %>%
  bindCache(input$tipo_grafica2, dataframe_rec_in())
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
