context("checkBackupParams")
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

test_that("checkBackupParams: Produces errors with missing parameters", {
  expect_error(checkBackupParams(basename='NULL', path='foo', version='0.1', verbose=FALSE, force=FALSE),     "Missing 'basename' parameter!")
  expect_error(checkBackupParams(basename='', path='foo', version='0.1', verbose=FALSE, force=FALSE),         "Cannot use empty string for 'basename'")
  expect_error(checkBackupParams(basename='projectX', path='', version='0.1', verbose=FALSE, force=FALSE),    "Cannot use empty string for 'path'")
  expect_error(checkBackupParams(basename='projectX', path='foo', version='', verbose=FALSE, force=FALSE),    "Cannot use empty string for 'version'")
  expect_error(checkBackupParams(basename='projectX', path='foo', version='0.1', verbose='FOO', force=FALSE), "'verbose' parameter must be TRUE or FALSE!")
  expect_error(checkBackupParams(basename='projectX', path='foo', version='0.1', verbose=FALSE, force='FOO'), "'force' parameter must be TRUE or FALSE!")
})

test_that("loadBackupFile: Produces errors with unsupported file extensions", {
  expect_error(loadBackupFile('projectX.12.12.12.FOO', FALSE), "not supported!")              
})

test_that("checkLoadBackupFile: Produces errors with non-existent files", {
  expect_error(checkLoadBackupFile('projectX.12.12.12.FOO', FALSE), "does not exist!")              
})

test_that("saveBackupFile: Produces errors with unsupported file extensions", {
  expect_error(saveBackupFile('projectX.12.12.12.FOO', FALSE), "not supported!")              
})

test_that("load.session: Produces errors with empty version string", {
  expect_error(load.session(basename='projectX', path='NULL', version='', verbose=FALSE), "Cannot use empty string for 'version'")              
})

test_that("getBackupFilenames returns a list" , {
  expect_output(str(getBackupFilenames('projectX', './', '12.12.12')), "List of 3")
})
  
saveBackupFile('projectX.12.12.12.RData', FALSE)
#saveBackupFile('projectX.12.12.12.RHistory', FALSE)
saveBackupFile('projectX.12.12.12.RInfo', FALSE)

test_that("saveBackupFile: Given correct inputs the function saves a file", {
  expect_that(file.exists(file.path("projectX.12.12.12.RData")), is_true())
  #expect_that(file.exists(file.path("projectX.12.12.12.RHistory")), is_true())
  expect_that(file.exists(file.path("projectX.12.12.12.RInfo")), is_true())
})

fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RInfo';    if (file.exists(fn)) file.remove(fn)


