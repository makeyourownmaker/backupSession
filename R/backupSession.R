


checkBackupParams <- function(basename, path, version, verbose, force) {
  
  if (basename == 'NULL') {
    stop("Missing 'basename' parameter!", call.=FALSE)
  }

  if (class(basename) != "character") {
    stop("'basename' parameter must be a character string!", call.=FALSE)
  }
  
  if (basename == '') {
    stop("Cannot use empty string for 'basename' parameter!", call.=FALSE)
  }

  
  if (class(path) != "character") {
    stop("'path' parameter must be a character string!", call.=FALSE)
  }
  
  if (path == '') {
    stop("Cannot use empty string for 'path' parameter!", call.=FALSE)
  }

  
  if (class(version) != "character") {
    stop("'version' parameter must be a character string!", call.=FALSE)
  }
  
  if (version == '') {
    stop("Cannot use empty string for 'version' parameter!", call.=FALSE)
  }
  
  
  if ( verbose != TRUE & verbose != FALSE ) {
    stop("'verbose' parameter must be TRUE or FALSE!", call.=FALSE)
  }

  
  if ( force != TRUE & force != FALSE ) {
    stop("'force' parameter must be TRUE or FALSE!", call.=FALSE)
  }
 
}


loadBackupFile <- function(loadFile, verbose) {

  if ( grepl("\\.RData$", loadFile, perl=TRUE) ) {
    load(file=loadFile)
  }
  else if ( grepl("\\.RHistory$", loadFile, perl=TRUE) ) {
    loadhistory(file=loadFile)
  }
  else if ( grepl("\\.RInfo$", loadFile, perl=TRUE) ) {
    sessionInformation <- readRDS(file=loadFile)
	baseName <- basename(loadFile)
    ext <- sub('.RInfo', '', baseName) # remove file extension and use filename as extension to sessionInfo variable
	sessionInfoExt <- paste0('sessionInfo.', ext)
	assign(sessionInfoExt, sessionInformation, envir = .GlobalEnv)	
	rm(sessionInformation)
  }
  else { 
    stop(paste0(loadFile, ' not supported!'), call.=FALSE)
  }
  
  if (isTRUE(verbose)) {
	message(paste0('Loaded ', loadFile))
  }
  
}


checkLoadBackupFile <- function(loadFile, verbose) {

  if (!file.exists(loadFile)) { # R 3.2.0 specific (April 2015)
	stop(paste0(loadFile, ' does not exist!'), call.=FALSE)
  }
  else {
    loadBackupFile(loadFile, verbose)
  }
  
}


saveBackupFile <- function(saveFile, verbose) {

  if ( grepl("\\.RData$", saveFile, perl=TRUE) ) {
    save.image(file=saveFile)
  }
  else if ( grepl("\\.RHistory$", saveFile, perl=TRUE) ) {
    savehistory(file=saveFile)
  }
  else if ( grepl("\\.RInfo$", saveFile, perl=TRUE) ) {
    saveRDS(sessionInfo(), file=saveFile)
  }
  else { 
    stop(paste0(saveFile, ' not supported!'), call.=FALSE)
  }
  
  if (isTRUE(verbose)) {
	message(paste0('Saved ', saveFile))
  }  
  
}


checkSaveBackupFile <- function(saveFile, force, verbose) {

  if (file.exists(saveFile)) { # R 3.2.0 specific (April 2015)
	warning(paste0(saveFile, ' exists!'), call.=FALSE)
	
	if (isTRUE(force)) {
	  warning(paste0('Overwriting ', saveFile, '!!'), call.=FALSE)	  
	  saveBackupFile(saveFile, verbose)
	}
	else {
	  warning(paste0('Not overwriting ', saveFile), call.=FALSE)
	}
  }
  else {
    saveBackupFile(saveFile, verbose)
  }
  
}


getBackupFilenames <- function(basename, path, version) {

  if (version=='NULL') {
	version  <- format(Sys.time(), "%y.%m.%d.%H.%M")
  }
  
  baseFile <- paste0(basename, '.', version)
  dataFile <- paste0(path, '/', baseFile, '.RData')
  infoFile <- paste0(path, '/', baseFile, '.RInfo')
  histFile <- paste0(path, '/', baseFile, '.RHistory')
  
  return(list(data=dataFile, info=infoFile, hist=histFile))
}



#' load.session Function
#'
#' This function loads R session images, history and session info files saved with save.session().
#' @param basename Basename for the R session images, history and session info files.
#' @param path Directory to load backup files from.  Defaults to current working directory.
#' @param version A date string or version number used as part of the backup filenames.  Cannot be an empty string.
#' @param verbose Print session loading progress messages.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @export
#' @examples
#' load.session(basename='projectX', path='./backups/', version='01.03.18.11.43')
load.session <- function(basename='NULL', path='NULL', version='NULL', verbose=FALSE) {

  checkBackupParams(basename, path, version, verbose, force=FALSE)
  
  if (path == 'NULL') { # R 3.2.0 specific
    path <- getwd()
	
	if (isTRUE(verbose)) {
	  message(paste0('Loading files from ', path))
	}
  }

  # This check is unnecessary in save.session(), so it's not included in checkBackupParams().
  if (version == 'NULL') {
    stop("Cannot use empty string for 'version' parameter!", call.=FALSE)
  }
  
  backupFiles <- getBackupFilenames(basename, path, version)

  # Check files exist and load them
  checkLoadBackupFile(backupFiles$data, verbose)  
  checkLoadBackupFile(backupFiles$hist, verbose)
  checkLoadBackupFile(backupFiles$info, verbose)

}


#' save.session Function
#'
#' This function saves R session images, history and session info files which can be loaded with load.session().
#' @param basename Basename for the R session images, history and session info files.
#' @param path Directory to save backup files to.  Defaults to current working directory.  Creates directories unless they exist.
#' @param version A date string or version number used as part of the backup filenames.  Cannot be an empty string.  Defaults to "%y.%m.%d.%H.%M" formatted timestamp.
#' @param verbose Print session loading progress messages.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @param force Overwrite existing files.  Must be either TRUE or FALSE.  Defaults to FALSE.
#' @export
#' @examples
#' save.session(basename='projectX', path='./backups/', version='01.03.18.11.43')
save.session <- function(basename='NULL', path='NULL', version='NULL', verbose=FALSE, force=FALSE) {

  checkBackupParams(basename, path, version, verbose, force)
 
  if (path == 'NULL') { # R 3.2.0 specific
    path <- getwd()
	
	if (isTRUE(verbose)) {
	  message(paste0('Saving files to ', path))
	}
  }
   
  # Create directory if not exists
  if (!dir.exists(path)) { # R 3.2.0 specific  
    tryCatch(dir.create(file.path(path), recursive=TRUE),
      error=function(c)   stop(paste0('Cannot create directory ', path, ":\n"), conditionMessage(c), call.=FALSE),
	  warning=function(c) stop(paste0('Cannot create directory ', path, ":\n"), conditionMessage(c), call.=FALSE),
	  message=function(c) warning(paste0('Created ', path, '!'), call.=FALSE)
    )
  }
  
  backupFiles <- getBackupFilenames(basename, path, version)

  # Check files don't exist and save them
  checkSaveBackupFile(backupFiles$data, force, verbose)  
  checkSaveBackupFile(backupFiles$hist, force, verbose)
  checkSaveBackupFile(backupFiles$info, force, verbose)
  
}



