context("Simple Functions")
library(backupSession)

test_that("loadBackupFile: Produces errors with unsupported file extensions", {
  expect_error(loadBackupFile('projectX.12.12.12.FOO', FALSE), "not supported!")              
})


test_that("checkLoadBackupFile: Produces errors with non-existent files", {
  expect_error(checkLoadBackupFile('projectX.12.12.12.FOO', FALSE), "does not exist!")              
})

save.session(basename='projectX', path='.', version='12.12.12')

test_that("checkLoadBackupFile: returns 0 on success", {
  expect_that(checkLoadBackupFile('projectX.12.12.12.RData', FALSE), equals(0))              
  expect_that(checkLoadBackupFile('projectX.12.12.12.RInfo', FALSE), equals(0))              
})

fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)


test_that("getBackupFilenames returns a list" , {
  expect_output(str(getBackupFilenames('projectX', './', '12.12.12')), "List of 3")
})
  

