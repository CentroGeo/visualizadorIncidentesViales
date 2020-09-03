#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
preprocesa_pgj <- function(pgj) {
  pgj["hora_de_hechos"] <-
    chron::times(paste0(substr(pgj$fecha_hechos, 12, 16), ":00"))
  pgj["fecha_de_hechos"] <-
    chron::dates(substr(pgj$fecha_hechos, 1, 10), format = "y-m-d")
  pgj["timestamp"] <-
    chron::chron(pgj$fecha_de_hechos, pgj$hora_de_hechos)
  pgj <-
    dplyr::filter(pgj, timestamp >= chron::dates("2016-01-01", format = "y-m-d"))
  pgj["geopoint"] <- NULL
  pgj <- pgj[order(pgj$timestamp),]
  pgj["id"] <- seq.int(nrow(pgj))
  pgj <- dplyr::filter(pgj,!is.na(latitud) & !is.na(longitud))
  pgj <- dplyr::filter(pgj,!is.na(timestamp))
  pgj <- sf::st_transform(sf::st_as_sf(
    pgj,
    coords = c("longitud", "latitud"),
    crs = 4326
  ), 32614)
  return(pgj)
}

#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
preprocesa_ssc <- function(ssc) {
  ssc <- janitor::clean_names(ssc, "snake")
  # =
  ssc$hora_evento <- chron::times(paste0(
    ifelse(nchar(ssc$hora2) == 1, paste0("0", ssc$hora2), ssc$hora2),
    ":",
    ifelse(
      stringr::str_sub(ssc$hora_evento,-1) == ".",
      substr(ssc$hora_evento, 4, 5),
      stringr::str_sub(ssc$hora_evento,-2)
    ),
    ":00"
  ))
  ssc$timestamp <- with(ssc, lubridate::ymd(ssc$fecha_evento) + lubridate::hms(ssc$hora_evento))
  # =
  ssc$no_folio[ssc$no_folio == "SD"] <-paste0("SinID_", seq(1:nrow(dplyr::filter(ssc, no_folio == "SD"))))
  tmp <- dplyr::filter(as.data.frame(table(ssc$no_folio), stringsAsFactors = FALSE), Freq > 1)
  for (i in tmp$Var1) {
    ssc$no_folio[ssc$no_folio == i] <-
      paste0(i, "_", seq(1:tmp[tmp$Var1 == i,]$Freq))
  }
  rm(tmp, i)
  ssc <- dplyr::filter(ssc,!is.na(coordenada_y) & !is.na(coordenada_x))
  ssc <- dplyr::filter(ssc,!is.na(timestamp))
  # =
  ssc <- sf::st_transform(sf::st_as_sf(
    ssc,
    coords = c("coordenada_x", "coordenada_y"),
    crs = 4326
  ), 32614)
  return(ssc)
}

#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
preprocesa_axa <- function(axa) {
  
}