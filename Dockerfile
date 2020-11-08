# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

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
    build-essential
 #   libcurl4-gnutls-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_github('CentroGeo/visualizadorIncidentesViales')"
# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "options('shiny.port'=3838,shiny.host='0.0.0.0'); options('Actualizar_datos' = TRUE); visualizadorIncidentesViales::run_app()"]
#CMD R -e "options('shiny.port'=1234,shiny.host='0.0.0.0', 'golem.pkg.name' = 'aaa');aaaa::run_app( 'runApp' )" 