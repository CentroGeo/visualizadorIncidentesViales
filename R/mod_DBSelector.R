#' DBSelector UI Function
#'
#' Genera todos los selectortes para filtrar la base de datos.
#' Tipo de incidente
#' Base de datos
#' Periodo de tiempo
#' Área de análisis
#' 
#' @param id shiny id
#'
#'
#' @importFrom shiny NS tagList
#'
mod_DBSelector_ui <- function(id) {
  ns <- NS(id)
  ## Lista de alcaldías
  list_selec <- c(
    "Total Ciudad de México", "Álvaro Obregón", "Azcapotzalco",
    "Benito Juárez", "Coyoacán", "Cuajimalpa de Morelos",
    "Cuauhtémoc", "Gustavo A. Madero", "Iztacalco", "Iztapalapa",
    "La Magdalena Contreras", "Miguel Hidalgo", "Milpa Alta",
    "Tlalpan", "Tláhuac", "Venustiano Carranza", "Xochimilco"
  )
  ## Lista de tipos de accidente
  tipo_incidentes <- c("Sin víctimas" = "ACCIDENTE",
                       "Lesionado" = "LESIONADO",
                       "Deceso" = "DECESO")
  bases <- c("FGJ", "SSC", "C5", "AXA")
  fluidPage(
    selectInput(
      inputId = ns("filtro_lugar"), ## referencia al valor
      label = "Área de Análisis",
      choices = list_selec,
      selected = "Total Ciudad de México"
    ),
    fluidRow(
      column(
        6,
        checkboxGroupInput(
          inputId = ns("filtro_incidente"),
          label = "Tipo de Incidente",
          inline = TRUE,
          choices = tipo_incidentes,
          selected = "LESIONADO"
        ),
        checkboxGroupInput(
          inputId = ns("filtro_bd"),
          label = "Base de Datos",
          inline = TRUE,
          choices = bases,
          selected = "FGJ"
        )
      )
    )
  )
}

#' filtra_datos
#'
#' Filtra los datos de acuerdo a los valores de los selectores.
#' 
#' @param datos_filtrados Todos los datos
#' @param filtro_incidente Tipo de incidente
#' @param filtro_bd Base de datos
#' @param filtro_intervalo Intervalo de tiempo
#' @param filtro_lugar Área de análisis
#'
#' @return datos filtrados
filtra_datos <- function(datos_filtrados,
                         filtro_incidente,
                         filtro_bd,
                         filtro_intervalo,
                         filtro_lugar) {
  datos_filtrados <- dplyr::filter(
    datos_filtrados,
    (datos_filtrados$timestamp > lubridate::ymd(filtro_intervalo[1])
    &
    datos_filtrados$timestamp < lubridate::ymd(filtro_intervalo[2])
    )
  )
  datos_filtrados <- dplyr::filter(datos_filtrados,
    fuente %in% filtro_bd) %>%
    dplyr::filter(tipo_incidente %in% filtro_incidente)
  ### Filter by location (Alcaldias)
  if (filtro_lugar != "Total Ciudad de México") {
    datos_filtrados <- dplyr::filter(datos_filtrados,
      nom_mun == filtro_lugar)
  }
  return(datos_filtrados)
}


#' DBSelector Server Function
#'
#' A partir de los filtros seleccionados por el usuario regresa un reactive con 
#' los datos filtrados.
#'
#'
#' @keywords internal
#' @param input shiny internal
#' @param output shiny  internal
#' @param session shiny internal
#' @param interval_ba_rea reactive con los valores seleccionados en la barra de tiempo
#' @return reactive con el dataframe de los valores filtrados
mod_DBSelector_server <- function(input, output, session,
  interval_ba_rea, datos_filtrados) {
    ns <- session$ns
    #### Read
    datafram_re <- reactive({
      filtro_incidente <- input$filtro_incidente
      filtro_bd <- input$filtro_bd
      filtro_intervalo <- interval_ba_rea()
      filtro_lugar <- input$filtro_lugar
      datos_filtrados <- dplyr::filter(
        datos_filtrados,
        (datos_filtrados$timestamp > lubridate::ymd(filtro_intervalo[1])
        &
        datos_filtrados$timestamp < lubridate::ymd(filtro_intervalo[2])
        )
      )
      datos_filtrados <- dplyr::filter(datos_filtrados,
        fuente %in% filtro_bd) %>%
        dplyr::filter(tipo_incidente %in% filtro_incidente)
      ### Filter by location (Alcaldias)
      if (filtro_lugar != "Total Ciudad de México") {
        datos_filtrados <- dplyr::filter(datos_filtrados,
          nom_mun == filtro_lugar)
      }      
      return(datos_filtrados)
    }) %>%
    bindCache(input$filtro_incidente, input$filtro_bd, 
              interval_ba_rea(), input$filtro_lugar)
    seleccion_lugar <- reactive({
      input$filtro_lugar
    })
    return(c(datafram_re, seleccion_lugar))
  }



## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")

## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
