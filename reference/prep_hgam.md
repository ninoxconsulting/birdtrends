# Prepare GAM components for running stan model

Prepare GAM components for running stan model

## Usage

``` r
prep_hgam(
  orig.preds = NA,
  nknots = 6,
  predpoints = NULL,
  npredpoints = 100,
  sm_name = "year"
)
```

## Arguments

- orig.preds:

  vector of years to be modeled

- nknots:

  numeric value for number of knots in model

- predpoints:

  values to be predicted. Default is NULL

- npredpoints:

  number of values to be predicted. Default is 100

- sm_name:

  name of model column outputs, default is "year

## Value

a list containing components of GAM model to be run within STAN

## Examples

``` r
if (FALSE) { # \dontrun{
aa <- prep_hgam(out$year, nknots = 6, predpoints = NULL, npredpoints = 100, sm_name = "year")
} # }
```
