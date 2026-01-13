# Get target values for plotting

Get target values for plotting

## Usage

``` r
get_targets(
  model_indices = ldf,
  ref_year = 2014,
  st_year = 2026,
  st_lu_target_pc = -2,
  st_up_target_pc = 1,
  lt_year = NA,
  lt_lu_target_pc = NA,
  lt_up_target_pc = NA
)
```

## Arguments

- model_indices:

  tibble of estimated indices drawn from fit\_\* function. Columns are
  draw, year, and proj_y

- ref_year:

  numeric year in which targets are compared to, default = 2014

- st_year:

  numeric short term year for which targets will be estimated

- st_lu_target_pc:

  numeric lower confidence interval of percentage of short term
  population change from reference year to st_year

- st_up_target_pc:

  numeric upper confidence interval of percentage of short term
  population change from reference year to st_year

- lt_year:

  numeric long term year for which targets will be estimated

- lt_lu_target_pc:

  numeric lower confidence interval of percentage of long term
  population change from reference year to lt_year

- lt_up_target_pc:

  numeric upper confidence interval of percentage of long term
  population change from reference year to lt_year

## Value

tibble with upper and lower target values

## Examples

``` r
if (FALSE) { # \dontrun{
  hgams_plot <- get_targets(model_indices = ldf, ref_year = 2014,
  st_year = 2026, st_lu_target_pc = -2,st_up_target_pc = 1,
   lt_year = 2046,  lt_lu_target_pc = 5,lt_up_target_pc = 15)
} # }
```
