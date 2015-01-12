context("list sites")

test_that("listing variables from site", {
  sites <- list_sites()
  list_timeseries(site = sites[1])
  expect_error(list_timeseries(site = 'bad_site_name'))
})

