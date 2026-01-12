test_that("get_trend results correct", {
  tr_dat <- readRDS(test_path("testdata", "fit_hgam_model.rds"))
  tr = get_trend(readRDS(test_path("testdata", "fit_hgam_model.rds")), start_yr = 1968, end_yr = 1977,annual_variation = FALSE)
  expect_equal(ncol(tr), 5)
  expect_equal(length(tr$draw), 10)
  trlm = get_trend(tr_dat, method = "lm",start_yr = 1968, end_yr = 1977)
  expect_equal(ncol(trlm), 5)
})

test_that("get_trend fails appropriately", {
  trr = readRDS(test_path("testdata", "fit_hgam_model.rds"))
  expect_error(get_trend("a"))
  #expect_error(get_trend(trr, method = "NA"))
  expect_message(get_trend(trr, start_yr = 1960, end_yr = 1970))
  expect_message(get_trend(trr, start_yr = 1970, end_yr = 2020))

  })

#testthat::test_file("tests/testthat/test-get_trend.R")
