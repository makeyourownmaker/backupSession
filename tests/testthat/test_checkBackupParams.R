context("checkBackupParams")
library(backupSession)

test_that("checkBackupParams: Produces errors with missing parameters", {
  expect_error(checkBackupParams(basename='NULL',     path='backups', version='0.1', verbose=FALSE, force=FALSE), "Missing 'basename' parameter")
  expect_error(checkBackupParams(basename='',         path='backups', version='0.1', verbose=FALSE, force=FALSE), "'basename' cannot be an empty string")
  expect_error(checkBackupParams(basename=66,         path='backups', version='0.1', verbose=FALSE, force=FALSE), "'basename' must be a character string")
  expect_error(checkBackupParams(basename='projectX', path='',        version='0.1', verbose=FALSE, force=FALSE), "'path' cannot be an empty string")
  expect_error(checkBackupParams(basename='projectX', path=66,        version='0.1', verbose=FALSE, force=FALSE), "'path' must be a character string")
  expect_error(checkBackupParams(basename='projectX', path='backups', version='',    verbose=FALSE, force=FALSE), "'version' cannot be an empty string")
  expect_error(checkBackupParams(basename='projectX', path='backups', version=66,    verbose=FALSE, force=FALSE), "'version' must be a character string")
  expect_error(checkBackupParams(basename='projectX', path='backups', version='0.1', verbose='0.1', force=FALSE), "'verbose' must be TRUE or FALSE")
  expect_error(checkBackupParams(basename='projectX', path='backups', version='0.1', verbose=FALSE, force='0.1'), "'force' must be TRUE or FALSE")
})

