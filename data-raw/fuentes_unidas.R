## code to prepare `fuentes_unidas` dataset goes here
fuentes_unidas <- readRDS("./data-raw/fuentes_unidas.rds")
usethis::use_data(fuentes_unidas, overwrite = TRUE)
