# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package("thinkr")
usethis::use_package("sf")
usethis::use_package("dplyr")
usethis::use_package("plyr")
usethis::use_package("readr")
usethis::use_package("magrittr")
usethis::use_package("chron")
usethis::use_package("lubridate")
usethis::use_package("jsonlite")
usethis::use_package("shinycssloaders")
usethis::use_package("shinydashboard")
usethis::use_package("shinyjs")
usethis::use_package("leaflet.extras")
usethis::use_package("htmltools")
usethis::use_package("janitor")
usethis::use_package("leaflet")
usethis::use_package("sp")
usethis::use_package("rgdal")
usethis::use_package("DT")
usethis::use_package("tidyr")
usethis::use_package("memoise")
usethis::use_pipe()


## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "introPageUI") # Página de inicio
golem::add_module(name = "csvFileUI") # Interfase de actualización de bases de datos
golem::add_module(name = "infoBdUI") # Ifo de las bases de datos
golem::add_module(name = "mapa") # Visualizador
golem::add_module(name = "bar") # Visualizador
golem::add_module(name = "DBSelector") # Visualizador
golem::add_module(name = "graficas") # Visualizador



## Add helper functions ----
## Creates ftc_* and utils_*
golem::add_fct("helpers")
golem::add_utils("helpers")

## External resources
## Creates .js and .css files at inst/app/www
# golem::add_js_file( "script" )
# golem::add_js_handler( "handlers" )
golem::add_css_file("custom")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "fgj", open = FALSE)
usethis::use_data_raw(name = "ssc", open = FALSE)
usethis::use_data_raw(name = "axa", open = FALSE)
usethis::use_data_raw(name = "cdmx", open = FALSE)
usethis::use_data_raw(name = "fuentes_unidas", open = FALSE)
usethis::use_data(fuentes_unidas, overwrite = TRUE)
usethis::use_data(cdmx, overwrite = TRUE)

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# Documentation

## Vignette ----
usethis::use_vignette("package")
devtools::build_vignettes()

## Code coverage ----
## (You'll need GitHub there)
usethis::use_github()
usethis::use_travis()
usethis::use_appveyor()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
