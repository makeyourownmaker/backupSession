context("checkBackupParams")
library(backupSession)

test_that("checkBackupParams: Produces errors with missing parameters", {
  expect_error(checkBackupParams(basename='NULL',     path='backups', version='0.1', verbose=FALSE, force=FALSE), "Missing 'basename' parameter!")
  expect_error(checkBackupParams(basename='',         path='backups', version='0.1', verbose=FALSE, force=FALSE), "Cannot use empty string for 'basename'")
  expect_error(checkBackupParams(basename='projectX', path='',        version='0.1', verbose=FALSE, force=FALSE), "Cannot use empty string for 'path'")
  expect_error(checkBackupParams(basename='projectX', path='backups', version='',    verbose=FALSE, force=FALSE), "Cannot use empty string for 'version'")
  expect_error(checkBackupParams(basename='projectX', path='backups', version='0.1', verbose='0.1', force=FALSE), "'verbose' parameter must be TRUE or FALSE!")
  expect_error(checkBackupParams(basename='projectX', path='backups', version='0.1', verbose=FALSE, force='0.1'), "'force' parameter must be TRUE or FALSE!")
})

