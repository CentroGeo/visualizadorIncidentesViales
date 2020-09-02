#' Title
#'
#' @param path 
#'
#' @return
#' @export
#'
#' @examples
preprocesa_pgj <- function(path){
  pgj <- read.csv(path, encoding = "UTF-8", stringsAsFactors = FALSE)
  # =
  pgj["hora_de_hechos"] <- times(paste0(substr(pgj$fecha_hechos, 12, 16), ":00"))
  pgj["fecha_de_hechos"] <- dates(substr(pgj$fecha_hechos, 1, 10), format = "y-m-d")
  pgj["timestamp"] <- chron(pgj$fecha_de_hechos, pgj$hora_de_hechos)
  pgj <- filter(pgj, timestamp >= dates("2016-01-01", format = "y-m-d"))
  # =
  pgj["geopoint"] <- NULL
  pgj <- pgj[order(pgj$timestamp), ]
  pgj["id"] <- seq.int(nrow(pgj))
  pgj <- filter(pgj, !is.na(latitud) & !is.na(longitud))
  pgj <- filter(pgj, !is.na(timestamp))
  # =
  pgj <- st_transform(st_as_sf(pgj, coords = c("longitud", "latitud"), crs = 4326), 32614)
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
preprocesa_ssc <- function(path){
  ssc <- read.csv(path, sep = ",", encoding = "UTF-8", stringsAsFactors = FALSE)
  ssc <- clean_names(ssc, "snake")
  # =
  ssc$fecha_evento <- dates(ssc$fecha_evento, format = "y-m-d")
  ssc$hora_evento <- times(paste0(ifelse(nchar(ssc$hora2) == 1, paste0("0", ssc$hora2), ssc$hora2), ":", ifelse(str_sub(ssc$hora_evento, -1) == ".", substr(ssc$hora_evento, 4, 5), str_sub(ssc$hora_evento, -2)), ":00"))
  ssc$timestamp <- chron(ssc$fecha_evento, ssc$hora_evento)
  # =
  ssc["no_folio"] <- as.character(ssc$no_folio)
  ssc$no_folio[ssc$no_folio == "SD"] <- paste0("SinID_", seq(1:nrow(filter(ssc, no_folio == "SD"))))
  tmp <- filter(as.data.frame(table(ssc$no_folio), stringsAsFactors = FALSE), Freq > 1)
  for (i in tmp$Var1) {
    ssc$no_folio[ssc$no_folio == i] <- paste0(i, "_", seq(1:tmp[tmp$Var1 == i, ]$Freq))
  }
  rm(tmp, i)
  # =
  ssc <- filter(ssc, !is.na(coordenada_y) & !is.na(coordenada_x))
  ssc <- filter(ssc, !is.na(timestamp))
  # =
  ssc <- st_transform(st_as_sf(ssc, coords = c("coordenada_x", "coordenada_y"), crs = 4326), 32614)
  return(ssc)
}