# Calculate change in trend between years

Calculate change in trend between years

## Usage

``` r
trend_change(projected_trends = preds_sm, ref_year = 2014, targ_year = 2026)
```

## Arguments

- projected_trends:

  tibble with all draws, years, projected trends, output of proj_trend
  function

- ref_year:

  numeric year in which change is measured from i.e. 2014

- targ_year:

  numeric year in which target will be reached i.e. 2026

## Value

tibble with the average percent change in addition to probability of
increase or decrease

## Examples

``` r
if (FALSE) { # \dontrun{
  test_st <- trend_change(predicted_trends = preds_sm,
        ref_year = 2014,
        targ_year = 2026)
} # }
```
