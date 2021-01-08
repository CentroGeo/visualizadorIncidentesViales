#' DBSelector UI Function
#'
#' Generate the UI for selecting the "Incidentes viales" data source,
#' type of accident and location
#'
#' @param id shiny id
#'
#'
#' @importFrom shiny NS tagList
#'
mod_DBSelector_ui <- function(id) {
  ns <- NS(id)
  ## Vector with the posible locations
  list_selec <- c(
    "Total Ciudad de México", "Álvaro Obregón", "Azcapotzalco",
    "Benito Juárez", "Coyoacán", "Cuajimalpa de Morelos",
    "Cuauhtémoc", "Gustavo A. Madero", "Iztacalco", "Iztapalapa",
    "La Magdalena Contreras", "Miguel Hidalgo", "Milpa Alta",
    "Tlalpan", "Tláhuac", "Venustiano Carranza", "Xochimilco"
  )
  ## Vector with the accident types
  tipo_incidentes <- c("Sin víctimas" = "ACCIDENTE",
                       "Lesionado" = "LESIONADO",
                       "Deceso" = "DECESO")
  bases <- c("FGJ", "SSC", "C5", "AXA")
  fluidPage(
    selectInput(
      inputId = ns("filtro_lugar"), ## Name to reference in the input
      label = "Área de Análisis", ##  Label in the UI
      choices = list_selec, # Vector of choices
      selected = "Total Ciudad de México" ## Selected by default
    ),
    fluidRow(
      column(
        6,
        checkboxGroupInput(
          inputId = ns("filtro_incidente"), ## Name to reference in the input
          label = "Tipo de Incidente", # Label to show in the UI
          inline = TRUE,
          choices = tipo_incidentes, ## Vector of choices
          selected = "LESIONADO" ## Selected by default
        ),
        checkboxGroupInput(
          inputId = ns("filtro_bd"), ## Name to reference in the input
          label = "Base de Datos", ## Label to show in the UI
          inline = TRUE,
          choices = bases, ## vector of  choices
          selected = "FGJ" ## Selected by default
        )
      )
    )
  )
}


filtra_datos <- function(dataframe_fil,
                         filtro_incidente,
                         filtro_bd,
                         filtro_intervalo,
                         filtro_lugar) {
  mem_data <- dplyr::filter(dataframe_fil,
    fuente %in% filtro_bd) %>%
    dplyr::filter(tipo_incidente %in% filtro_incidente)
  #### filtro fecha
  mem_data <- dplyr::filter(
    mem_data,
    (mem_data$timestamp > lubridate::ymd(filtro_intervalo[1])
    &
    mem_data$timestamp < lubridate::ymd(filtro_intervalo[2])
    )
  )
  ### Filter by location (Alcaldias)
  if (filtro_lugar != "Total Ciudad de México") {
    mem_data <- dplyr::filter(mem_data,
      nom_mun == filtro_lugar)
  }
  return(mem_data)
}
cache_dir_o <- getOption("Cache_dir", default = "./cache_dir")

fc <- memoise::cache_filesystem(cache_dir_o)

mem_filtra_datos <- memoise::memoise(
                              filtra_datos,
                              cache= fc
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
  interval_ba_rea, dataframe_fil) {
    ns <- session$ns
    #### Read
    datafram_re <- reactive({
      filtro_incidente <- input$filtro_incidente
      filtro_bd <- input$filtro_bd
      filtro_intervalo <- interval_ba_rea()
      filtro_lugar <- input$filtro_lugar
      dataframe_fil <- mem_filtra_datos(dataframe_fil, filtro_incidente,
        filtro_bd, filtro_intervalo, filtro_lugar)
      return(dataframe_fil)
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
