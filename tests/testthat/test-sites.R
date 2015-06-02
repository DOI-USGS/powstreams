context("list sites")

test_that("listing variables from site fails", {
  #expect_error(list_timeseries(site = 'bad_site_name'))
  #expect_error(download_timeseries(site = 'bad_site_name', variable = 'doobs'))
  #expect_error(load_timeseries(site = 'bad_site_name', variable = 'doobs'))
  #expect_error(download_watershed(site = 'bad_site_name'))
  
  #expect_is(list_sites(), 'character')
  #expect_is(list_sites(with_timeseries = 'wtr'), 'character')
  #expect_is(list_sites(with_timeseries = c('wtr', 'doobs')), 'character')
  
  #expect_is(download_watershed(site = "nwis_01408500"), 'character')
  #expect_is(load_timeseries(site = "nwis_01408500", variable = 'doobs'), 'data.frame')
  #expect_is(load_timeseries(site = 'nwis_01408500', variable = c('doobs','wtr')), 'data.frame')
  
  expect_is(site_location("nwis_11126000"), 'data.frame')
  expect_error(site_location("11126000"))
  expect_is(site_location(c("nwis_11126000", "nwis_09258980")), 'data.frame')
  
})

