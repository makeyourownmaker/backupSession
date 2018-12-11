context("saveBackupFile")
library(backupSession)


test_that("saveBackupFile: Produces errors with unsupported file extensions", {
  expect_error(saveBackupFile('projectX.12.12.12.NOPE', FALSE), "not supported!")              
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


