
# backupSession <img src="man/figures/logo.png" align="right" />

[![Travis-CI Build 
Status](https://travis-ci.org/makeyourownmaker/backupSession.svg?branch=master)](https://travis-ci.org/makeyourownmaker/backupSession)
[![codecov
](https://codecov.io/github/makeyourownmaker/backupSession/branch/master/graphs/badge.svg)](https://codecov.io/github/makeyourownmaker/backupSession)
![Lifecycle 
](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=flat)
![Version
](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![Dependencies
](https://img.shields.io/badge/dependencies-none-brightgreen.svg?style=flat)

backupSession is an R package for saving and loading consistently named and versioned R session images, history and sessionInfo().

## Installation

Requires R version 3.2.0 and up

```
# install.packages("devtools") # Install devtools package if necessary
library(devtools)
devtools::install_github("makeyourownmaker/backupSession")
```

## Usage

```
library(backupSession)
# Work, work, work ...
save.session(basename='projectX', version='01.03.18.11.43', path='./backups')
q('no')

# Start new R session
library(backupSession)
load.session(basename='projectX', version='01.03.18.11.43', path='./backups')
```

## Details

The save.session function saves three files: 
1) R session image in path/basename.version.RData
2) R history in path/basename.version.RHistory
3) R sessionInfo() in path/basename.version.RInfo

The load.session function loads these three files into the current R session.  It will overwrite existing data.

The path parameter defaults to the current working directory.  The save.session function will create directories specified
using the path parameter unless they exist.

The version parameter in the save.session function defaults to a timestamp ("%y.%m%.%d.%H.%M") unless an alternative is specified.

Both save.session and load.session have verbose options which print session saving and loading progress messages respectively.

The force option in the save.session function will overwrite existing files.

The load.session function will add a sessionInfo<version> variable to the global environment.  This variable contains
the sessionInfo() string stored in the .RInfo file.

The [testthat](http://testthat.r-lib.org/) package is required to run the tests but is not required for normal installations.


Further info:
```
?save.session
?load.session
```


## Limitations

History files are not saved during __non-interactive__ R sessions.


## Roadmap

* Increase test coverage
* Make CRAN release
* Add meta data file (MData)
  * Check if loading a backup will overwrite existing data in current R session
  * Summarise changes between backups
  * Remove excess backup files


## Alternatives

* [logR: Flexible logging of R console sessions](https://github.com/jdthorpe/logR)
* [track: Store Objects on Disk Automatically](https://cran.r-project.org/web/packages/track/index.html)


## Contributing
Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.


## License
[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
