#' Fit hierarchical GAM using annual indices and confidence interval
#'
#' @param indata dataframe with annual indices by year (row) and confidence intervals
#' @param start_yr numeric year at which to start model. Default is the first year available
#' @param end_yr numeric year at which to end model. Default is the last year available
#' @param n_knots number of knots used in the HGAM model, using default of one knot per 4 years of data
#' @param longform TRUE/FALSE the output will be converted to a longform tibble with columns draw, year, proj_y. Default = TRUE
#' @return tibble with modeled HGAM indices for given years
#' @export
#'
#' @examples
#' \dontrun{
#'outsmooth <- fit_hgam(indata = indat1, start_yr = 1970, end_yr = 2020, n_knots = 5)
#'}
fit_hgam <- function(indata, start_yr = NA, end_yr = NA,  n_knots = NA, longform = TRUE){

  if (!requireNamespace("cmdstanr", quietly = TRUE)) {
    stop('You need to install the cmdstanr package; install with:
  install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))')
  }

  # testing
  # indata = indat1
  # start_yr = NA#1990
  # end_yr = NA
  # n_knots = NA

  min_yr <- min(indata$year)
  max_yr <- max(indata$year)


 # allyr_seq <- indata$year

  if(is.na(start_yr)) {
    start_yr <- min_yr
  } else {
    if(start_yr < min_yr) {
      message("`start_yr` is before the date range, using minimum year of ",
              "the data (", start_yr <- min_yr, ") instead.")
    }
  }

  if (is.na(end_yr)) {
    end_yr <- max_yr
  } else {
    if(end_yr > max_yr) {
    message("`max_year` is beyond the date range, using maximum year of ",
            "the data (", end_yr <- max_year, ") instead.")
    }
  }


  # create a list of year to use
  year_seq = indata$year
  year_seq = year_seq[year_seq >= start_yr]
  year_seq = year_seq[year_seq <= end_yr]


  # filter years of interest and add sd
  out <- indata |>
    dplyr::filter(year %in% year_seq) |>
    dplyr::mutate(ln_index = log(index),
                  ln_index_lci = log(index_q_0.025),
                  ln_index_uci = log(index_q_0.975),
                  ln_index_sd = (ln_index_uci - ln_index_lci)/(1.96*2),
                  yearn = year-(min(year)-1))


  n_years <- as.integer(length(min(out$year):max(out$year)))
  n_indices <- as.integer(nrow(out))

  if(is.na(n_knots)){
    n_knots <- as.integer(round(n_indices/4))
    message("`n_knots` is not defined, using default of one knot per 4 years of data ",
            "using n_knots = ",  n_knots, ".")
  }

  gam_data <- prep_hgam(out$year,
                        nknots = n_knots,
                        sm_name = "year")

  # create a stan list to run model
  stan_data <- list(
    n_years = n_years,
    n_indices = n_indices,
    n_knots_year = gam_data$nknots_year,
    year = out$yearn,
    ln_index = out$ln_index,
    ln_index_sd = out$ln_index_sd,
    year_basis = gam_data$year_basis
  )

  ## fit model with cmdstanr

  file <- system.file("models", "GAM_smooth_model.stan", package = "birdtrends")

 # file <- "inst/models/GAM_smooth_model.stan"
  mod <- cmdstanr::cmdstan_model(file)

  fit_gam <- mod$sample(data = stan_data,
                        parallel_chains = 4,
                        refresh = 0,
                        adapt_delta = 0.95)


  # check this with Adam:  as it only shows q5 and not : q2_5

  sum <- fit_gam$summary(variables = NULL,
                         "mean",
                         "sd",
                         "ess_bulk",
                         "rhat")#,
                         #q2_5 = q2_5,
                         #q97_5 = q97_5)

  mx_rhat <- max(sum$rhat,na.rm = TRUE)

  if(mx_rhat > 1.05){stop("High Rhat value")}


  smooths <- posterior::as_draws_df(fit_gam) |>
    dplyr::select(dplyr::matches("^smooth_n([[:punct:]])"))


  colnames(smooths) <- as.character(out$year)

  if(longform){
    #
    smooths <- tibble::rowid_to_column( smooths, "draw") %>%
      tidyr::pivot_longer(., cols = !starts_with("d")) %>%
      dplyr::rename('year' = name, "proj_y" = value)%>%
      dplyr::mutate(year = as.integer(year))

  }

  return(smooths)


}
