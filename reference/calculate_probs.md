# Calculate probability of meeting targets

Calculate probability of meeting targets

## Usage

``` r
calculate_probs(
  projected_trends = preds_sm,
  ref_year = 2014,
  targ_year = 2026,
  prob_decrease = NULL,
  prob_increase = NULL
)
```

## Arguments

- projected_trends:

  tibble with all draws, years, projected trends, output of proj_trend
  function

- ref_year:

  numeric year in which change is measured from i.e. 2014

- targ_year:

  numeric year in which target will be reached i.e. 2026

- prob_decrease:

  numeric vector of predicted target increase. i.e c(25, 35). Determine
  the probability that trend will increase 25% to 35% by target year

- prob_increase:

  numeric vector of predicted target decrease. i.e c(25, 35). Determine
  the probability that trend will decline by 25% to 35% by target year

## Value

tibble with the average percent change in addition to probability of
increase or decrease

## Examples

``` r
if (FALSE) { # \dontrun{
  test_st <- calculate_probs(predicted_trends = preds_sm,
        ref_year = 2014,
        targ_year = 2026,
        prob_increase = c(targ$st_pop_pc_lower,targ$st_pop_pc_uppper))
} # }
```
