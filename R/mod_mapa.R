#' mapa UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_mapa_ui <- function(id){
  ns <- NS(id)
  #####Aqui va el mapa 
  fluidPage(
    leaflet::leafletOutput(ns("myMap"), height = '756px')
  )
  
}
    
#' mapa Server Function
#'
#' @noRd 
mod_mapa_server <- function( input, output, session ){
  cdmx <- sf::read_sf(dsn = "./data/cdmx.shp", layer = "cdmx")
  #######  To set map 
  lugar <- cdmx
  lon <- -99.152613
  lat <- 19.320497
  zoom <- 10
  
  output$myMap<-leaflet::renderLeaflet({
    leaflet::leaflet(data = lugar) %>%
      leaflet::addTiles(urlTemplate = '//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png') %>%
      leaflet::setView(lng = lon , lat = lat, zoom = zoom) %>%
      leaflet::addPolygons(fillColor = '#00A65A' , fillOpacity = 0.10 , color = '#006738' , opacity = 0.75)
  })
  # output$myMap <- leaflet::renderLeaflet({
  #   leaflet::leaflet() %>%
  #   leaflet::addProviderTiles( leaflet::providers$Stamen.TonerLite,
  #                                options = leaflet::providerTileOptions(noWrap = TRUE))
  # 
  # })
 
}
    
## To be copied in the UI
# mod_mapa_ui("mapa_ui_1")
    
## To be copied in the server
# callModule(mod_mapa_server, "mapa_ui_1")
 
