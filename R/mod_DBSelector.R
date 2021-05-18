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

# Esta sólo se encarga de que exista el objeto cache 
fc <- function(cache_selected = "./cache_dir") {
  
  dir.create(cache_selected,  showWarnings = FALSE)
  fc_c <- memoise::cache_filesystem(cache_selected)
  print(paste("Path for DB cache Storage: ", cache_selected))
  return (fc_c)
}

# Versión memoizada de filtra_datos
mem_filtra_datos <- memoise::memoise(
                              filtra_datos,
                              cache = fc(getOption(
                                            "Cache_DB_dir",
                                             default = "./cache_dir"
                                             )
                                        )
                            )

#' DBSelector Server Function
#'
#' Using the filters selected in the UI the function returns a reactive function that returns
#' a dataframe filtered using the corresponding filters.
#'
#'
#'
#' @keywords internal
#' @param input shiny internal
#' @param output shiny  internal
#' @param session shiny internal
#' @param interval_ba_rea Interval reactive that returne time
#' interval to select data
#' @return reactive function that returns a filtered dataframe
#'  using the inputs from the UI
mod_DBSelector_server <- function(input, output, session,
  interval_ba_rea, datos_filtrados) {
    ns <- session$ns
    #### Read
    datafram_re <- reactive({
      filtro_incidente <- input$filtro_incidente
      filtro_bd <- input$filtro_bd
      filtro_intervalo <- interval_ba_rea()
      filtro_lugar <- input$filtro_lugar
      datos_filtrados <- mem_filtra_datos(datos_filtrados, filtro_incidente,
        filtro_bd, filtro_intervalo, filtro_lugar)
      return(datos_filtrados)
    })
    #datafram_re <- datafram_re %>% shiny::debounce(100)
    seleccion_lugar <- reactive({
      input$filtro_lugar
    })
    return(c(datafram_re, seleccion_lugar))
  }



## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")

## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
