context("list sites")

test_that("get site information", {
  
  expect_is(get_site_info("nwis_11126000"), "unitted_data.frame")
  expect_is(get_site_info(c("nwis_11126000", "nwis_09258980")), "unitted_data.frame")
  expect_is(get_site_info(c("nwis_11126000", "nwis_09258980"), attach.units=FALSE), "data.frame")
  
  expect_warning(expect_is(get_site_info(c("junksite", "nwis_09258980")), "unitted_data.frame"), "unrecognized")
  expect_warning(expect_equal(dim(get_site_info(c("junksite", "nwis_09258980"))), c(2,7)))
  expect_warning(expect_equal(dim(get_site_info(c("junksite", "nwis_09258980"), on_missing="omit")), c(1,7)), "unrecognized.*junksite")
  
})

