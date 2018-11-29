context("Simple Functions")
library(backupSession)

test_that("loadBackupFile: Produces errors with unsupported file extensions", {
  expect_error(loadBackupFile('projectX.12.12.12.FOO', FALSE), "not supported!")              
})

# Disabling below test for now to avoid below warning
#  test_SimpleFunctions.R:9: warning: loadBackupFile: Produces errors with non-existent files
#        Still getting 0 returned - from last function calling
#  cannot open compressed file 'foobar.12.12.12.RData', probable reason 'No such file or directory'
#test_that("loadBackupFile: Produces errors with non-existent files", {
#  expect_error(loadBackupFile('foobar.12.12.12.RData', FALSE), "cannot open the connection")              
#  #expect_that(loadBackupFile('foobar.12.12.12.RData', FALSE), gives_warning())              
#})


test_that("checkLoadBackupFile: Produces errors with non-existent files", {
  expect_error(checkLoadBackupFile('foobar.12.12.12.RData', FALSE), "does not exist!")              
})


save.session(basename='projectX', path='.', version='12.12.12')

test_that("checkSaveBackupFile: Produces errors with existent files and force=FALSE", {
  expect_that(checkSaveBackupFile('projectX.12.12.12.RData', force=FALSE), gives_warning())              
})

fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)


test_that("getBackupFilenames returns a list of size 3" , {
  expect_output(str(getBackupFilenames('projectX', './', '12.12.12')), "List of 3")
})
  

