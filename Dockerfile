# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:3.6.3

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libudunits2-0 \
    libudunits2-dev \
    libgdal-dev \
    libgit2-dev \
    build-essential
 #   libcurl4-gnutls-de

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

RUN mkdir /visualizadorIncidentesViales
RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"
ADD ./ /visualizadorIncidentesViales/
RUN R -e "devtools::install_local('/visualizadorIncidentesViales')"
RUN mkdir /tmp/vis-viales-cache

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", \
    "options('shiny.port'=3838,shiny.host='0.0.0.0'); \
     options('Actualizar_datos' = FALSE); \
     library(visualizadorIncidentesViales); \
     shiny::shinyOptions(cache = cachem::cache_disk(file.path(dirname(tempdir()), 'vis-viales-cache'))); \
     visualizadorIncidentesViales::run_app()"]
# CMD ["R", "-e", \
#     "devtools::install_github('CentroGeo/visualizadorIncidentesViales', force=TRUE); \
#     options('shiny.port'=3838,shiny.host='0.0.0.0'); \
#     options('Actualizar_datos' = TRUE); \
#     visualizadorIncidentesViales::run_app()"]
###
### To run the docker container using the volume "Cache_vol" 
#### docker run  -v Cache_vol:./cache_visualizador -p 3838:3838/tcp visualizadorIncidentesviales:0.9.1.2
