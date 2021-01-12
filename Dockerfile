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

RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_github('CentroGeo/visualizadorIncidentesViales', force=TRUE)"

###Make dir for cache
RUN mkdir ./cache_dir
# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", \
    "options('shiny.port'=3838,shiny.host='0.0.0.0'); \
    options('Actualizar_datos' = TRUE); \
    options('Cache_dir'='./cache_dir');\
    options('Cache_DB_dir'='./cache_dir');\ 
    library(visualizadorIncidentesViales); \
    visualizadorIncidentesViales::run_app()"]
# CMD ["R", "-e", \
#     "devtools::install_github('CentroGeo/visualizadorIncidentesViales', force=TRUE); \
#     options('shiny.port'=3838,shiny.host='0.0.0.0'); \
#     options('Actualizar_datos' = TRUE); \
#     visualizadorIncidentesViales::run_app()"]
###
### To run the docker container using the volume "Cache_vol" 
#### docker run  -v Cache_vol:./cache_visualizador -p 3838:3838/tcp visualizadorIncidentesviales:0.9.1.2
