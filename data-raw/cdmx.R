## code to prepare `cdmx` dataset goes here
cdmx <- sf::read_sf(dsn = "./data-raw/cdmx.shp", layer = "cdmx")
usethis::use_data(cdmx, overwrite = TRUE)
