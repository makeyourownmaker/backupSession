context("save.session")
library(backupSession)

# NOTE covr::package_coverage() can't savehistory() because not running in
#      interactive() environment
#      testthat package doesn't have this problem??
#      So, in future if desperate to create a fake history file do something like:
#      if (! interactive()) { write.file(1, file="fakehistory.RHistory") }
#
#' save.session(basename='projectX', path='./backups/', version='01.03.18.11.43')
#save.session <- function(basename='NULL', path='NULL', version='NULL', verbose=FALSE, force=FALSE) {
save.session(basename='projectX', path='.', version='12.12.12')


test_that("save.session: Given correct inputs the function saves expected files", {
  expect_that(file.exists(file.path("projectX.12.12.12.RData")),     is_true())
  expect_that(file.exists(file.path("projectX.12.12.12.RInfo")),     is_true())
  #expect_that(file.exists(file.path("projectX.12.12.12.RHistory")), is_true()) # works with testthat but not with covr::package_coverage()
})

fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)


