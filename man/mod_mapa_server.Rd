% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_mapa.R
\name{mod_mapa_server}
\alias{mod_mapa_server}
\title{mapa Server Function}
\usage{
mod_mapa_server(input, output, session, datos)
}
\arguments{
\item{input}{shiny Parameter where the inputs from the UI are store}

\item{output}{shiny parameter where the id are
reference to display in the UI}

\item{session}{shiny parameter to store the session}

\item{datos}{reactive dataframe with data filterd by user parameters}
}
\description{
Despliega y actualiza el mapa de acuerdo a la selección del usuario.
}
