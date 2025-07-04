#' Generate trend based based on multiple draws of annual indices
#'
#' @param proj_data tibble of estimated indices drawn from fit_* function. Columns are draw, year, and proj_y
#' @param start_yr numeric value of the first year in which trend will be calculated. Default is first available year within the dataset
#' @param end_yr numeric value representing the last year in which trend will be calculated. Default is first available year within the dataset
#' @param method character of method used to calculate trend. Two methods available; geometric mean ("gmean" as default )or "lm" linear regression
#' @param annual_variation logical Estimate trends that capture some of the annual variation in rate of change. If FALSE (default), then trends are estimated for a single time-period (start_yr : end_yr), if TRUE, then trends are estimated for all possible 1-yr intervals for the selected time period. For example, if start_yr = 2012 and end_yr = 2022, then there will be 10 sets of annual trends estimated (2012:2013, 2013:2014, etc.)
#'
#' @return tibble with estimated trend and percent_trend for each draw
#' @export
#'
#' @examples
#' \dontrun{
#'  ldf_smooths <- tibble::rowid_to_column(fitted_smooths, "draw") %>%
#'       tidyr::pivot_longer(., cols = !starts_with("d")) %>%
#'       dplyr::rename('year' = name, "proj_y" = value)%>%
#'       dplyr::mutate(year = as.integer(year))
#'  trend_sm <- get_trend(ldf_smooths, start_yr = 2014, end_yr = 2022, method = "gmean")
#'}
get_trend <- function(proj_data, start_yr = NA, end_yr = NA, method = "gmean", annual_variation = FALSE){

  #   # testing
  # proj_data <- ldf_smooths
  # start_yr = 1990
  # end_yr = 2000
  # method = "lm"

  min_yr <- min(proj_data$year)
  max_yr <- max(proj_data$year)

  if(is.na(start_yr)) {
    start_yr <-  min_yr
  } else {
    if(start_yr < min_yr) {
      message("`start_yr` is before the date range, using minimum year of ",
              "the data (", start_yr <- min_yr, ") instead.")
    }
  }

  if (is.null(end_yr)) {
    end_yr <- max_yr
  } else if(end_yr > max_yr) {
    message("`max_year` is beyond the date range, using maximum year of ",
            "the data (", end_yr <- max_year, ") instead.")
  }

  if (annual_variation & method == "lm"){
    message("Changing method to gmean, because annual trends cannot be calculated
            with method = lm")
    method <- "gmean"
  }

  # subset data based on the selected years
  trend_dat <- subset(proj_data, year %in% seq(start_yr, end_yr))

if(!annual_variation){
  if(method == "gmean") {

    # estimate the trend based on the years of selection for each draw
    # this relies on trend_dat being sorted by year
    # is there a risk that it might not be sorted?
    trend_sum <- trend_dat %>%
      dplyr::group_by(draw) %>%
      dplyr::summarise(trend_log = mean(diff(log(proj_y)))) %>%
      dplyr::mutate(perc_trend = 100*(exp(trend_log)-1),
                    trend_start_year = start_yr,
                    trend_end_year = end_yr)
    # this is mathematically equivalent to the end-point trends on the smooth
    # that are defined in Smith and Edwards 2020 https://doi.org/10.1093/ornithapp/duaa065
    # e.g.,
    # trend_sum_alt <- trend_dat %>%
    #   dplyr::filter(year %in% c(start_yr,end_yr)) %>%
    #   dplyr::group_by(draw) %>%
    #   dplyr::summarise(trend_log = (diff(log(proj_y)))/(end_yr-start_yr)) %>%
    #   dplyr::mutate(perc_trend = 100*(exp(trend_log)-1))

  }  else if (method == "lm"){

    lm_mod <- function(df){
      stats::lm(log(proj_y) ~ year, data = df)}

    trend_df <- trend_dat %>%
      dplyr::group_by(draw) %>%
      tidyr::nest()

    trend_lms <- trend_df %>% dplyr::mutate(model = purrr::map(data, lm_mod))

    trend_sum <- trend_lms %>%
      dplyr::mutate(tidy = purrr::map(model, broom::tidy),
             trend_log = broom::tidy %>% purrr::map_dbl(function(x) x$estimate[2])) %>%
      dplyr::select(c(-model, -tidy, -data)) %>%
      tidyr::unnest(cols = c(draw))%>%
      dplyr::mutate(perc_trend = 100*(exp(trend_log)-1),
                    trend_start_year = start_yr,
                    trend_end_year = end_yr)

  }
}else{
  trend_sum <- NULL

  for(yint in c(start_yr:(end_yr-1))){
  trend_dat1 <- subset(trend_dat, year %in% c(yint:(yint+1)))
  trend_sum1 <- trend_dat1 %>%
    dplyr::group_by(draw) %>%
    dplyr::summarise(trend_log = mean(diff(log(proj_y)))) %>%
    dplyr::mutate(perc_trend = 100*(exp(trend_log)-1),
                  trend_start_year = yint,
                  trend_end_year = yint+1)
  trend_sum <- dplyr::bind_rows(trend_sum,trend_sum1)
  }
}
  return(trend_sum)

}



