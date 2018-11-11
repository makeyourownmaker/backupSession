context("checkBackupParams")
library(backupSession)

test_that("checkBackupParams: Produces errors with missing parameters", {
  expect_error(checkBackupParams(basename='NULL',     path='foo', version='0.1', verbose=FALSE, force=FALSE), "Missing 'basename' parameter!")
  expect_error(checkBackupParams(basename='',         path='foo', version='0.1', verbose=FALSE, force=FALSE), "Cannot use empty string for 'basename'")
  expect_error(checkBackupParams(basename='projectX', path='',    version='0.1', verbose=FALSE, force=FALSE), "Cannot use empty string for 'path'")
  expect_error(checkBackupParams(basename='projectX', path='foo', version='',    verbose=FALSE, force=FALSE), "Cannot use empty string for 'version'")
  expect_error(checkBackupParams(basename='projectX', path='foo', version='0.1', verbose='FOO', force=FALSE), "'verbose' parameter must be TRUE or FALSE!")
  expect_error(checkBackupParams(basename='projectX', path='foo', version='0.1', verbose=FALSE, force='FOO'), "'force' parameter must be TRUE or FALSE!")
})

