# Project generated trends into the future

Project generated trends into the future

## Usage

``` r
proj_trend(proj_output, trend_output, start_yr = NA, proj_yr = 2046)
```

## Arguments

- proj_output:

  tibble of estimated indices drawn from fit\_\* function. Columns are
  draw, year, and proj_y

- trend_output:

  tibble of estimated trends generated from get_trends\* function.

- start_yr:

  numeric year of the first projected date

- proj_yr:

  numeric year to which trend will be projected

## Value

datatable with modeled and predicted values into the future

## Examples

``` r
if (FALSE) { # \dontrun{
 trend_sm <- predict_trend(ldf_smooths, trend_sm, start_yr = 2023, proj_yr = 2046)
} # }
```
