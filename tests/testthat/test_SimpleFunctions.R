context("Simple Functions")
library(backupSession)

test_that("loadBackupFile: Produces errors with unsupported file extensions", {
  expect_error(loadBackupFile('projectX.12.12.12.FOO', FALSE), "not supported!")              
})

test_that("checkLoadBackupFile: Produces errors with non-existent files", {
  expect_error(checkLoadBackupFile('projectX.12.12.12.FOO', FALSE), "does not exist!")              
})

test_that("getBackupFilenames returns a list" , {
  expect_output(str(getBackupFilenames('projectX', './', '12.12.12')), "List of 3")
})
  

