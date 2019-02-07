context("load.session")
library(backupSession)

test_that("load.session: Produces errors with empty version string", {
  expect_error(load.session(basename='projectX', path='NULL', version='', verbose=FALSE), "'version' cannot be an empty string")
})

test_that("load.session: Given non-existent files will fail", {
  expect_that(load.session(basename='Yproject', path='.', version='12.12.12'), throws_error())
})


test_that("load.session: Succeeds with backup under tests/testthat directory", {
  expect_error(load.session(basename='iris.example', version='19.01.14.13.22'), NA)
})

