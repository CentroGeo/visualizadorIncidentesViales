# Visualizador de incidentes viales

Este repositorio contiene una implementación en [Shiny](https://shiny.rstudio.com/) de un visualizador para las bases de datos sobre incidentes viales publicadas por:

* [Fiscalía General de Justicia](https://datos.cdmx.gob.mx/explore/dataset/carpetas-de-investigacion-pgj-de-la-ciudad-de-mexico/information/?disjunctive.ao_hechos&disjunctive.delito)
* [Secretaría de Seguridad Ciudadana](https://datos.cdmx.gob.mx/explore/dataset/hechos-de-transito-reportados-por-ssc-base-comparativa/information/)
* [Seguros AXA](https://i2ds.org/datos-abiertos/)

## Instrucciones de instalación

Utilizando [devtools](https://cran.r-project.org/web/packages/devtools/index.html), desde una consola de `R`:

````R
> devtools::installgithub("CentroGeo/visualizadorIncidentesViales")
> library(visualizadorIncidentesViales)
> visualizadorIncidentesViales::run_app()
````



## Desarrollo

El visualizador está desarrollado modularmente. Cada componente de la interfase corresponde a un [módulo de Shiny](https://shiny.rstudio.com/articles/modules.html).

La estructura general de la interfase se puede ver en los archivos `R/app_ui.R` y `R/app_server.R`. El primero contiene la estructura de la interfase y el segundo la lógica de uso.

Cada componente, tanto de `R/app_ui.R` como de `R/app_server.R` corresponde a un módulo en la misma carpeta. Los módulos contienen dos funciones, una para la interfase y uno para el servidor. Dentro de cada módulo está contenida toda la lógica del funcionamiento de cada elemento.





|<!-- -->|<!-- -->| | | |
|:--------------:|:--------------:|:--------------:|:--------------:|:--------------:|
| <img src="inst/app/www/logo_semovi.png" width="200">    | <img src="inst/app/www/axa.png" width="100">    | <img src="inst/app/www/conacyt.png" width="100"> | <img src="inst/app/www/centrogeo.png" width="100"> | <img src="inst/app/www/datalab.png" width="100">| |
