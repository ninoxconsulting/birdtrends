# Generate trend based based on multiple draws of annual indices

Generate trend based based on multiple draws of annual indices

## Usage

``` r
get_trend(
  proj_data,
  start_yr = NA,
  end_yr = NA,
  method = "gmean",
  annual_variation = FALSE
)
```

## Arguments

- proj_data:

  tibble of estimated indices drawn from fit\_\* function. Columns are
  draw, year, and proj_y

- start_yr:

  numeric value of the first year in which trend will be calculated.
  Default is first available year within the dataset

- end_yr:

  numeric value representing the last year in which trend will be
  calculated. Default is first available year within the dataset

- method:

  character of method used to calculate trend. Two methods available;
  geometric mean ("gmean" as default )or "lm" linear regression

- annual_variation:

  logical estimate trends that capture some of the annual variation in
  rate of change. If FALSE (default), then trends are estimated for a
  single time-period (start_yr : end_yr), if TRUE, then trends are
  estimated for all possible 1-yr intervals for the selected time
  period. For example, if start_yr = 2012 and end_yr = 2022, then there
  will be 10 sets of annual trends estimated (2012:2013, 2013:2014,
  etc.)

## Value

tibble with estimated trend and percent_trend for each draw

## Examples

``` r
if (FALSE) { # \dontrun{
 ldf_smooths <- tibble::rowid_to_column(fitted_smooths, "draw") %>%
      tidyr::pivot_longer(., cols = !starts_with("d")) %>%
      dplyr::rename('year' = name, "proj_y" = value)%>%
      dplyr::mutate(year = as.integer(year))
 trend_sm <- get_trend(ldf_smooths, start_yr = 2014, end_yr = 2022, method = "gmean")
} # }
```
