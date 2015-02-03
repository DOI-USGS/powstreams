context("list sites")

test_that("listing variables from site fails", {
  expect_error(list_timeseries(site = 'bad_site_name'))
  expect_error(download_timeseries(site = 'bad_site_name', variable = 'doobs'))
  expect_error(load_timeseries(site = 'bad_site_name', variable = 'doobs'))
  expect_error(download_watershed(site = 'bad_site_name'))
  
  expect_is(download_watershed(site = "nwis_01408500"), 'character')
  expect_is(load_timeseries(site = "nwis_01408500", variable = 'doobs'), 'data.frame')
  
  
})

