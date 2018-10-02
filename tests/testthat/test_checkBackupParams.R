context("checkBackupParams")
library(backupSession)

test_that("checkBackupParams produces errors with missing parameters", {
  expect_error(checkBackupParams(basename="NULL", path="foo", version="0.1", verbose=FALSE, force=FALSE), "Missing 'basename' parameter!")
})

