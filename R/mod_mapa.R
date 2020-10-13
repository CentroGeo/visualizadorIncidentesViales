#' mapa UI Function
#'
#' @description Selection of databases
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' 
#' @return a map
mod_mapa_ui <- function(id) {
  ns <- NS(id)
  #####Aqui va el mapa
  fluidPage(
    leaflet::leafletOutput(outputId = ns("myMap"), height = "756px")
  )
}
    
#' mapa Server Function
#'
#' @noRd 
mod_mapa_server <- function(input, output, session, datos) {
  cdmx <- sf::read_sf(dsn = "./data/cdmx.shp", layer = "cdmx")
  #######  To set map
  lugar <- cdmx
  lon <- -99.152613
  lat <- 19.320497
  zoom <- 10
  map <-  leaflet::leaflet(data = lugar) %>%
            leaflet::addTiles(
              urlTemplate = '//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
              ) %>%
            leaflet::setView(lng = lon, lat = lat, zoom = zoom) %>%
            leaflet::addPolygons(fillColor = "#00A65A",
              fillOpacity = 0.10,
              color = "#006738",
              opacity = 0.75)
  output$myMap <- leaflet::renderLeaflet({map})
  icons <- leaflet::iconList(
    DECESO = leaflet::makeIcon("www/pgj_a.png"),
    LESIONADO = leaflet::makeIcon("www/pgj_b.png"),
    ACCIDENTE = leaflet::makeIcon("www/pgj_c.png")
  )
  observeEvent(datos(), ignoreNULL = FALSE, {
    datos_4326 <- sf::st_transform(datos(), "+init=epsg:4326")
    leaflet::leafletProxy("myMap") %>% leaflet::addMarkers(
      data = datos_4326,
      clusterOptions = leaflet::markerClusterOptions(),
      icon = ~icons[tipo_incidente])
  })
}
    
## To be copied in the UI
# mod_mapa_ui("mapa_ui_1")
