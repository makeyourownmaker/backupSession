context("load.session")
library(backupSession)

test_that("load.session: Produces errors with empty version string", {
  expect_error(load.session(basename='projectX', path='NULL', version='', verbose=FALSE), "Cannot use empty string for 'version'")              
})


