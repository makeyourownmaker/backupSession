context("load.session")
library(backupSession)

test_that("load.session: Produces errors with empty version string", {
  expect_error(load.session(basename='projectX', path='NULL', version='', verbose=FALSE), "Cannot use empty string for 'version'")              
})

test_that("load.session: Given non-existent files will fail", {
  expect_that(load.session(basename='foobar', path='.', version='12.12.12'), throws_error())
})


