


checkBackupParams <- function(basename, path, version, verbose, force) {
  if (basename == "NULL") {
    stop("Missing 'basename' parameter.", call. = FALSE)
  }

  if (class(basename) != "character") {
    errmsg <- paste0(
      "'basename' must be a character string:\n",
      "* 'basename' is a ", class(basename), "."
    )
    stop(errmsg, call. = FALSE)
  }

  if (basename == "") {
    stop("'basename' cannot be an empty string.", call. = FALSE)
  }


  if (class(path) != "character") {
    errmsg <- paste0(
      "'path' must be a character string:\n",
      "* 'path' is a ", class(path), "."
    )
    stop(errmsg, call. = FALSE)
  }

  if (path == "") {
    stop("'path' cannot be an empty string.", call. = FALSE)
  }


  if (class(version) != "character") {
    errmsg <- paste0(
      "'version' must be a character string:\n",
      "* 'version' is a ", class(version), "."
    )
    stop(errmsg, call. = FALSE)
  }

  if (version == "") {
    stop("'version' cannot be an empty string.", call. = FALSE)
  }


  if (verbose != TRUE & verbose != FALSE) {
    errmsg <- paste0(
      "'verbose' must be TRUE or FALSE:\n",
      "* 'verbose' is ", verbose, "."
    )
    stop(errmsg, call. = FALSE)
  }


  if (force != TRUE & force != FALSE) {
    errmsg <- paste0(
      "'force' must be TRUE or FALSE:\n",
      "* 'force' is ", force, "."
    )
    stop(errmsg, call. = FALSE)
  }

  return(0)
}


loadBackupFile <- function(loadFile, verbose = FALSE) {
  if (grepl("\\.RData$", loadFile, perl = TRUE)) {
    load(file = loadFile, envir = .GlobalEnv)
  }
  else if (grepl("\\.RHistory$", loadFile, perl = TRUE)) {
    if (interactive()) {
      utils::loadhistory(file = loadFile)
    } else {
      warning("Cannot load history in non-interactive R session.", call. = FALSE)
    }
  }
  else {
    errmsg <- paste0(
      loadFile, " not supported:\n",
      "* 'RData' & 'RHistory' files supported."
    )
    stop(errmsg, call. = FALSE)
  }

  if (isTRUE(verbose)) {
    message(paste0("Loaded ", loadFile, "."))
  }

  return(0)
}


checkLoadBackupFile <- function(loadFile, verbose = FALSE) {
  if (!file.exists(loadFile)) { # R 3.2.0 specific (April 2015)
    # Don't warn about missing RHistory files (ref. non-interactive R session problem)
    if (grepl("\\.RHistory$", loadFile, perl = TRUE)) {
      warning(paste0(loadFile, " does not exist."), call. = FALSE)
    }
    else {
      errmsg <- paste0(
        loadFile, " does not exist:\n",
        "* Check full file path?"
      )
      stop(errmsg, call. = FALSE)
    }
  }
  else {
    loadBackupFile(loadFile, verbose)
  }

  return(0)
}


saveBackupFile <- function(saveFile, verbose = FALSE) {
  if (grepl("\\.RData$", saveFile, perl = TRUE)) {
    save.image(file = saveFile)
  }
  else if (grepl("\\.RHistory$", saveFile, perl = TRUE)) {
    if (interactive()) {
      utils::savehistory(file = saveFile)
    } else {
      warning("Cannot save history file in non-interactive R session.", call. = FALSE)
    }
  }
  else if (grepl("\\.SInfo$", saveFile, perl = TRUE)) {
    saveRDS(utils::sessionInfo(), file = saveFile)
  }
  else if (grepl("\\.MData$", saveFile, perl = TRUE)) {
    saveRDS(utils::ls.str(all.names = TRUE, envir = .GlobalEnv), file = saveFile)
  }
  else {
    errmsg <- paste0(
      saveFile, " not supported:\n",
      "* 'RData', 'RHistory' & 'SInfo' files supported."
    )
    stop(errmsg, call. = FALSE)
  }

  if (isTRUE(verbose)) {
    message(paste0("Saved ", saveFile, "."))
  }

  return(0)
}


checkSaveBackupFile <- function(saveFile, force = FALSE, verbose = FALSE) {
  if (file.exists(saveFile)) { # R 3.2.0 specific (April 2015)
    warning(paste0(saveFile, " already exists:"), call. = FALSE)

    if (isTRUE(force)) {
      warning(paste0("* Overwriting ", saveFile, "."), call. = FALSE)
      saveBackupFile(saveFile, verbose)
    }
    else {
      warning(paste0("* Not overwriting ", saveFile, "."), call. = FALSE)
    }
  }
  else {
    saveBackupFile(saveFile, verbose)
  }

  return(0)
}


getBackupFilenames <- function(basename, path, version) {

  baseFile  <- paste0(basename, ".", version)
  dataFile  <- file.path(path, paste0(baseFile, ".RData"))
  infoFile  <- file.path(path, paste0(baseFile, ".SInfo"))
  histFile  <- file.path(path, paste0(baseFile, ".RHistory"))
  mDataFile <- file.path(path, paste0(baseFile, ".MData"))

  return(list(data = dataFile, info = infoFile, hist = histFile, mdata = mDataFile))
}


#' load.mdata Function
#'
#' This function loads R metadata (output of ls.str() function)
#'
#' @param basename Basename for the R metadata file.
#' @param path Directory to load file from.  Defaults to current working directory.
#' @param version A date string or version number used as part of the backup filename.  Cannot be an empty string.
#' @param verbose Print file loading progress messages.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @seealso \code{\link{load.session}}, \code{\link{save.session}} and \code{\link{load.sinfo}}
#' @export
#' @examples
#'\dontrun{
#' mData <- load.mdata(basename = "projectX", path = "./backups", version = "01.03.18.11.43")
#'}
load.mdata <- function(basename = "NULL", version = "NULL", path = getwd(), verbose = FALSE) {
  checkBackupParams(basename, path, version, verbose, force = FALSE)

  # This check is unnecessary in save.session(), so it's not included in checkBackupParams().
  if (version == "NULL") {
    stop("Missing 'version' parameter.", call. = FALSE)
  }

  backupFiles <- getBackupFilenames(basename, path, version)
  loadFile <- backupFiles$mdata
  metaData <- NA

  if (grepl("\\.MData$", loadFile, perl = TRUE)) {
    if (file.exists(loadFile)) { # R 3.2.0 specific (April 2015)
      metaData <- readRDS(file = loadFile)
    } else {
      errmsg <- paste0(
        loadFile, " does not exist:\n",
        "* Check full file path?"
      )
      stop(errmsg, call. = FALSE)
    }
  }

  if (isTRUE(verbose)) {
    message(paste0("Loaded ", loadFile, "."))
  }

  return(metaData)
}


#' load.sinfo Function
#'
#' This function loads R session information (output of sessionInfo() function)
#'
#' @param basename Basename for the R session info file.
#' @param path Directory to load file from.  Defaults to current working directory.
#' @param version A date string or version number used as part of the backup filename.  Cannot be an empty string.
#' @param verbose Print file loading progress messages.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @seealso \code{\link{load.session}}, \code{\link{save.session}} and \code{\link{load.mdata}}
#' @export
#' @examples
#'\dontrun{
#' sInfo <- load.sinfo(basename = "projectX", path = "./backups", version = "01.03.18.11.43")
#'}
load.sinfo <- function(basename = "NULL", version = "NULL", path = getwd(), verbose = FALSE) {
  checkBackupParams(basename, path, version, verbose, force = FALSE)

  # This check is unnecessary in save.session(), so it's not included in checkBackupParams().
  if (version == "NULL") {
    stop("Missing 'version' parameter.", call. = FALSE)
  }

  backupFiles <- getBackupFilenames(basename, path, version)
  loadFile    <- backupFiles$info
  sessionInfo <- ''

  if (grepl("\\.SInfo$", loadFile, perl = TRUE)) {
    if (file.exists(loadFile)) { # R 3.2.0 specific (April 2015)
      sessionInfo <- readRDS(file = loadFile)
    } else {
      errmsg <- paste0(
        loadFile, " does not exist:\n",
        "* Check full file path?"
      )
      stop(errmsg, call. = FALSE)
    }
  }

  if (isTRUE(verbose)) {
    message(paste0("Loaded ", loadFile, "."))
  }

  return(sessionInfo)
}


#' load.session Function
#'
#' This function loads R session images and if available history files saved with save.session().
#'
#' It will overwrite objects in .GlobalEnv just as the load() function does.
#' History files are NOT loaded in non-interactive R sessions.
#'
#' @param basename Basename for the R session images and history files.
#' @param path Directory to load backup files from.  Defaults to current working directory.
#' @param version A date string or version number used as part of the backup filenames.  Cannot be an empty string.
#' @param verbose Print session loading progress messages.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @seealso \code{\link{save.session}}, \code{\link{load.mdata}} and \code{\link{load.sinfo}}
#' @export
#' @examples
#'\dontrun{
#' load.session(basename = "projectX", path = "./backups", version = "01.03.18.11.43")
#'}
load.session <- function(basename = "NULL", version = "NULL", path = getwd(), verbose = FALSE) {
  a <- checkBackupParams(basename, path, version, verbose, force = FALSE)

  # This check is unnecessary in save.session(), so it's not included in checkBackupParams().
  if (version == "NULL") {
    stop("Missing 'version' parameter.", call. = FALSE)
  }

  backupFiles <- getBackupFilenames(basename, path, version)

  if (isTRUE(verbose)) {
    message(paste0("Loading files from ", path, "...\n"))
  }

  # Check files exist and load them
  b <- checkLoadBackupFile(backupFiles$data,  verbose)
  c <- checkLoadBackupFile(backupFiles$hist,  verbose)
}


#' save.session Function
#'
#' This function saves R session images, history, ls.str() and sessionInfo() files which can be loaded with load.session(), load.mdata() and load.sinfo().
#'
#' History files are NOT saved in non-interactive R sessions.
#'
#' @param basename Basename for the R session images, history and session info files.
#' @param path Directory to save backup files to.  Defaults to current working directory.  Creates directories unless they exist.
#' @param version A date string or version number used as part of the backup filenames.  Cannot be an empty string.  Defaults to year.month.date.hour.minute formatted timestamps.
#' @param verbose Print session loading progress messages.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @param force Overwrite existing files.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @seealso \code{\link{load.session}}, \code{\link{load.mdata}} and \code{\link{load.sinfo}}
#' @export
#' @examples
#' save.session(basename = "projectX", path = "./backups", version = "01.03.18.11.43")
save.session <- function(basename = "NULL", version = format(Sys.time(), "%y.%m.%d.%H.%M"), path = getwd(), verbose = FALSE, force = FALSE) {
  a <- checkBackupParams(basename, path, version, verbose, force)

  # Create directory if not exists
  if (!dir.exists(path)) { # R 3.2.0 specific
    tryCatch(dir.create(file.path(path), recursive = TRUE),
      error   = function(c) stop(paste0("Cannot create directory ", path, ":\n"), conditionMessage(c), call. = FALSE),
      warning = function(c) stop(paste0("Cannot create directory ", path, ":\n"), conditionMessage(c), call. = FALSE),
      message = function(c) warning(paste0("Created ", path, "."), call. = FALSE)
    )
  }

  backupFiles <- getBackupFilenames(basename, path, version)

  if (isTRUE(verbose)) {
    message(paste0("Saving files to ", path, "...\n"))
  }

  # Check files don't exist and save them
  b <- checkSaveBackupFile(backupFiles$data,  force, verbose)
  c <- checkSaveBackupFile(backupFiles$hist,  force, verbose)
  d <- checkSaveBackupFile(backupFiles$info,  force, verbose)
  e <- checkSaveBackupFile(backupFiles$mdata, force, verbose)
}


#' backupSession: Save and Load R Session Images, History, metadata and sessionInfo
#'
#' Save and load consistently named and versioned session images, history, metadata and sessionInfo().
#' This package will save and load four types of files: 1) R session images, 2) R command histories, 3) R ls.str() output and 4) R sessionInfo() output.
#' See \code{\link{save.session}}, \code{\link{load.session}}, \code{\link{load.mdata}} and \code{\link{load.sinfo}} for usage examples and further information.
#'
#' @docType package
#' @name backupSession
NULL
