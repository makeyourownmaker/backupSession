context("All Functions")
library(backupSession)

test_that("All functions: Given zero parameters, error is thrown", {
  # scenario: No arguments provided
  expect_that(checkBackupParams(),   throws_error())
  expect_that(loadBackupFile(),      throws_error())
  expect_that(checkLoadBackupFile(), throws_error())
  expect_that(saveBackupFile(),      throws_error())
  expect_that(checkSaveBackupFile(), throws_error())
  expect_that(getBackupFilenames(),  throws_error())
  expect_that(load.session(),        throws_error())
  expect_that(save.session(),        throws_error())
})

