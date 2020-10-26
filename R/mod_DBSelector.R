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
  tipo_incidentes <- c("ACCIDENTE", "LESIONADO", "DECESO")
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
mod_DBSelector_server <- function(input, output, session, interval_ba_rea) {
  ns <- session$ns
  #### Read
  cdmx <- sf::read_sf(dsn = "./data/cdmx.shp", layer = "cdmx")
  datafram_re <- reactive({
    ## Read the resulting dataframe from the mod_csvFileUI
    dataframe_fil <- readRDS("./data-raw/fuentes_unidas.rds")
    ######  
    dataframe_fil <- dataframe_fil[dataframe_fil$fuente %in% input$filtro_bd, ]
    ## filter by type of accident
    dataframe_fil <- dataframe_fil[dataframe_fil$tipo_incidente %in%
                                   input$filtro_incidente, ]
    dataframe_fil <- dataframe_fil[!is.na(dataframe_fil$tipo_incidente), ]
    #### filtro fecha
    interval_bar <- interval_ba_rea() ## Get the interbal from the time bar
    dataframe_fil <- dplyr::filter(
      dataframe_fil,
      (dataframe_fil$timestamp > lubridate::ymd(interval_bar[1])
      &
        dataframe_fil$timestamp < lubridate::ymd(interval_bar[2]))
    )
    ### Filter by location (Alcaldias)
    if (input$filtro_lugar != "Total Ciudad de México") {
      tmp_contains <- sf::st_contains(
        sf::st_transform(
          cdmx[cdmx$nom_mun == input$filtro_lugar, ],
          32614
        ),
        dataframe_fil
      )
      dataframe_fil <- dataframe_fil[tmp_contains[[1]], ]
    }
    return(dataframe_fil)
  })
  seleccion_lugar <- reactive({
    input$filtro_lugar
  })
  return(c(datafram_re, seleccion_lugar))
}



## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")

## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
