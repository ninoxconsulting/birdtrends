# Fit hierarchical GAM using annual indices and confidence interval

Fit hierarchical GAM using annual indices and confidence interval

## Usage

``` r
fit_hgam(indata, start_yr = NA, end_yr = NA, n_knots = NA, longform = TRUE)
```

## Arguments

- indata:

  dataframe with annual indices by year (row) and confidence intervals

- start_yr:

  numeric year at which to start model. Default is the first year
  available

- end_yr:

  numeric year at which to end model. Default is the last year available

- n_knots:

  number of knots used in the HGAM model, using default of one knot per
  4 years of data

- longform:

  TRUE/FALSE the output will be converted to a longform tibble with
  columns draw, year, proj_y. Default = TRUE

## Value

tibble with modeled HGAM indices for given years

## Examples

``` r
if (FALSE) { # \dontrun{
outsmooth <- fit_hgam(indata = indat1, start_yr = 1970, end_yr = 2020, n_knots = 5)
} # }
```
