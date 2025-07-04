#' Project generated trends into the future
#'
#' @param proj_output tibble of estimated indices drawn from fit_* function. Columns are draw, year, and proj_y
#' @param trend_output tibble of estimated trends generated from get_trends* function.
#' @param start_yr numeric year of the first projected date
#' @param proj_yr numeric year to which trend will be projected
#'
#' @return datatable with modeled and predicted values into the future
#' @export
#'
#' @examples
#' \dontrun{
#'  trend_sm <- predict_trend(ldf_smooths, trend_sm, start_yr = 2023, proj_yr = 2046)
#'}
proj_trend <- function(proj_output,
                       trend_output,
                       start_yr = NA,
                       proj_yr = 2046){

  ## testing
  # proj_output <- ldf_smooths
  # trend_output <- trend_sm
  # start_yr = 2023
  # proj_yr = 2046

  #proj_output = ldf
  #trend_output  = trend_sm
  #proj_output  = indata1
  #trend_output = tr

  if(is.na(start_yr)){
    start_yr <- max_yr <- max(proj_output$year)+ 1
  }

  if(start_yr - (max(proj_output$year)) > 1){
    stop("Start year of prediction is too far in advance, choose a year no more than 1 year more than maximum year of data")
  }

    trend_end_years <- unique(trend_output$trend_end_year)


  pred_inds_start_yr <- proj_output %>%
    dplyr::filter(year == start_yr-1) %>%
    dplyr::rename(starting_pred_ind = proj_y) %>%
    dplyr::select(-year)

  pred_out <- expand.grid(draw = 1:max(proj_output$draw),
                          year = min(proj_output$year):proj_yr,
                          trend_end_year = trend_end_years) %>%
    dplyr::full_join(trend_output,
                     by = c("draw","trend_end_year")) %>%
    dplyr::full_join(proj_output,
                     by = c("draw","year")) %>%
    dplyr::full_join(pred_inds_start_yr,
                     by = "draw") %>%
    dplyr::mutate(pred_ind = ifelse(year < start_yr,
                                    proj_y,
                                  exp(log(starting_pred_ind) + (trend_log*(year-(start_yr-1))))))


  return(pred_out)

}

