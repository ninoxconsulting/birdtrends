% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/proj_trend.R
\name{proj_trend}
\alias{proj_trend}
\title{Project generated trends into the future}
\usage{
proj_trend(proj_output, trend_output, start_yr = NA, proj_yr = 2046)
}
\arguments{
\item{proj_output}{tibble of estimated indices drawn from fit_* function. Columns are draw, year, and proj_y}

\item{trend_output}{tibble of estimated trends generated from get_trends* function.}

\item{start_yr}{numeric year of the first projected date}

\item{proj_yr}{numeric year to which trend will be projected}
}
\value{
datatable with modeled and predicted values into the future
}
\description{
Project generated trends into the future
}
\examples{
\dontrun{
 trend_sm <- predict_trend(ldf_smooths, trend_sm, start_yr = 2023, proj_yr = 2046)
}
}
