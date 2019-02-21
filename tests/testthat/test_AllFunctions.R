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
  expect_that(load.sinfo(),          throws_error())
  expect_that(load.mdata(),          throws_error())
  expect_that(load.session(),        throws_error())
  expect_that(save.session(),        throws_error())
})


save.session(basename='projectX', path='.', version='12.12.12')

test_that("checkBackupParams: returns 0 on success", {
  expect_that(checkBackupParams(basename='projectX', path='.', version='12.12.12', verbose=FALSE, force=FALSE), equals(0))              
})

test_that("checkLoadBackupFile: returns 0 on success", {
  expect_that(checkLoadBackupFile('projectX.12.12.12.RData'), equals(0))              
})

test_that("loadBackupFile: returns 0 on success", {
  expect_that(loadBackupFile('projectX.12.12.12.RData'), equals(0))              
})

test_that("checkSaveBackupFile: returns 0 on success", {
  expect_that(checkSaveBackupFile('projectX.11.11.11.RData'), equals(0))              
})

test_that("saveBackupFile: returns 0 on success", {
  expect_that(saveBackupFile('projectX.10.10.10.RData'), equals(0))              
})

test_that("save.session: returns 0 on success", {
  expect_that(save.session(basename='projectX', path='.', version='09.09.09'), equals(0))              
})

test_that("load.session: returns 0 on success", {
  expect_that(load.session(basename='projectX', path='.', version='09.09.09'), equals(0))              
})

test_that("load.sinfo: returns sessionInfo() class on success", {
  expect_equal(class(load.sinfo(basename='projectX', path='.', version='09.09.09')), "sessionInfo")
})

test_that("load.mdata: returns sessionInfo() class on success", {
  expect_equal(class(load.mdata(basename='projectX', path='.', version='09.09.09')), "ls_str")
})

fn <- 'projectX.12.12.12.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.MData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.12.12.12.RHistory'; if (file.exists(fn)) file.remove(fn)

fn <- 'projectX.11.11.11.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.11.11.11.MData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.11.11.11.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.11.11.11.RHistory'; if (file.exists(fn)) file.remove(fn)

fn <- 'projectX.10.10.10.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.10.10.10.MData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.10.10.10.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.10.10.10.RHistory'; if (file.exists(fn)) file.remove(fn)

fn <- 'projectX.09.09.09.RData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.09.09.09.MData';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.09.09.09.SInfo';    if (file.exists(fn)) file.remove(fn)
fn <- 'projectX.09.09.09.RHistory'; if (file.exists(fn)) file.remove(fn)

