context("save.session")
library(backupSession)

# NOTE covr::package_coverage() can't savehistory() because not running in
#      interactive() environment
#      testthat package doesn't have this problem??
#      So, in future if desperate to create a fake history file do something like:
#      if (! interactive()) { write.file(1, file="fakehistory.RHistory") }

test_that("save.session: Given correct inputs the function does not return any errors", {
  expect_error(save.session(basename='projectX', path='.', version='12.12.12'), NA)
})

test_that("save.session: Given correct inputs the function saves expected files", {
  expect_that(file.exists(file.path("projectX.12.12.12.RData")),     is_true())
  expect_that(file.exists(file.path("projectX.12.12.12.SInfo")),     is_true())
  #expect_that(file.exists(file.path("projectX.12.12.12.RHistory")), is_true()) 
  # Commented out line above works with testthat but not with covr::package_coverage()
  # Problem concerns differences between interactive and non-interactive environments
})

test_that("save.session: Given existent files and force=FALSE will give warning", {
  expect_that(save.session(basename='projectX', path='.', version='12.12.12', force=FALSE), gives_warning())
})

# Clean up
fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)


test_that("save.session: Given correct inputs, but no path, the function does not return any errors", {
  expect_error(save.session(basename='projectX', version='12.12.12'), NA)
})

test_that("save.session: Given correct inputs, but no path, the function saves expected files", {
  expect_that(file.exists(file.path("projectX.12.12.12.RData")),     is_true())
  expect_that(file.exists(file.path("projectX.12.12.12.SInfo")),     is_true())
  #expect_that(file.exists(file.path("projectX.12.12.12.RHistory")), is_true()) 
  # Commented out line above works with testthat but not with covr::package_coverage()
  # Problem concerns differences between interactive and non-interactive environments
})

# Clean up
fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)


dn <- 'newDir'; if (file.exists(dn)) unlink(dn, recursive=TRUE)
test_that("save.session: Given correct inputs, and non-existent path, the function does not return any errors", {
  expect_error(save.session(basename='projectX', path='newDir', version='12.12.12'), NA)
})

test_that("save.session: Given correct inputs, and non-existent path, the function saves expected files", {
  expect_that(file.exists(file.path("newDir/projectX.12.12.12.RData")),     is_true())
  expect_that(file.exists(file.path("newDir/projectX.12.12.12.SInfo")),     is_true())
  #expect_that(file.exists(file.path("newDir/projectX.12.12.12.RHistory")), is_true()) 
  # Commented out line above works with testthat but not with covr::package_coverage()
  # Problem concerns differences between interactive and non-interactive environments
})

# Clean up
fn <- 'newDir/projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'newDir/projectX.12.12.12.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'newDir/projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)
dn <- 'newDir'; if (file.exists(dn)) unlink(dn, recursive=TRUE)

