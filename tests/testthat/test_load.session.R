context("load.session")
library(backupSession)

test_that("load.session: Produces errors with empty version string", {
  expect_error(load.session(basename='projectX', path='NULL', version='', verbose=FALSE), "Cannot use empty string for 'version'")              
})

test_that("load.session: Given non-existent files will fail", {
  expect_that(load.session(basename='Yproject', path='.', version='12.12.12'), throws_error())
})


test_that("load.session: Succeeds with backup under data directory", {
  expect_error(load.session(basename='iris.example', version='19.01.14.13.22'), NA)
})

#foo <- load.session(basename='iris.example', version='19.01.14.13.22')
#foo <- ls()
#test_that("load.session: Succeeds with backup under data directory", {
#  expect_that(length(foo), equals(4))
#})

