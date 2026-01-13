# Fit gam models on posterior draws

Fit gam models on posterior draws

## Usage

``` r
fit_gam(indata, start_yr = NA, end_yr = NA, n_knots = NA, longform = TRUE)
```

## Arguments

- indata:

  dataframe of posterior draws. Each column is a year, each row is a
  posterior draw

- start_yr:

  numeric year at which to start model. Default is the first year
  available

- end_yr:

  numeric year at which to end model. Default is the last year available

- n_knots:

  number of knots used in the gam model, default is 5

- longform:

  TRUE/FALSE the output will be converted to a longform tibble with
  columns draw, year, proj_y. Default = TRUE

## Value

dataframe with predicted

## Examples

``` r
if (FALSE) { # \dontrun{
pred_dataset <- fit_gam(indat2, start_yr = 1990, end_yr = 2020, n_knots = 14)
} # }
```
