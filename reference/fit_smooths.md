# Extract Smooths from BBS model run

Extract Smooths from BBS model run

## Usage

``` r
fit_smooths(indata, start_yr = NA, end_yr = NA, longform = TRUE)
```

## Arguments

- indata:

  dataframe of generated smooths. Each column is a year, each row is a
  predicted smooth

- start_yr:

  numeric year at which to start, if subset is required. Default is the
  last year available

- end_yr:

  numeric year at which to end, if subset is required. Default is the
  last year available

- longform:

  TRUE/FALSE the output will be converted to a longform tibble with
  columns draw, year, proj_y. Default = TRUE

## Value

dataframe with smooths generated for each year of the selected range

## Examples

``` r
if (FALSE) { # \dontrun{
smooths <- fit_smooths(indat3, start_yr = 1990, end_yr = 2020)
} # }
```
