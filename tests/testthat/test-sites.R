context("list sites")

test_that("listing variables from site fails", {
  
  expect_is(site_location("nwis_11126000"), "unitted_data.frame")
  expect_is(site_location(c("nwis_11126000", "nwis_09258980")), "unitted_data.frame")
  
})

