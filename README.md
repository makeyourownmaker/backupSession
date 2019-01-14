
# backupSession

[![Travis-CI Build Status](https://travis-ci.org/makeyourownmaker/backupSession.svg?branch=master)](https://travis-ci.org/makeyourownmaker/backupSession)[![codecov]
(https://codecov.io/github/makeyourownmaker/backupSession/branch/master/graphs/badge.svg)](https://codecov.io/github/makeyourownmaker/backupSession)[![Dependencies]
(https://img.shields.io/badge/dependencies-none-brightgreen.svg?style=flat)][![Development Stage]
(https://img.shields.io/badge/development%20stage-beta-brightgreen.svg?style=flat)]

backupSession is an R package for saving and loading consistently named and versioned R session images, history and sessionInfo().

## Installation

### Requirements
* R 3.2 and up

```
# install.packages("devtools")
library(devtools)
devtools::install_github("makeyourownmaker/backupSession")
```

## Usage

```library(backupSession)

save.session(basename='projectX', path='./backups/', version='01.03.18.11.43')
load.session(basename='projectX', path='./backups/', version='01.03.18.11.43')
```

## Details

The save.session function saves three files: 
1) R session image in basename.version.RData
2) R history in basename.version.RHistory
3) R sessionInfo() in basename.version.RInfo

The load.session function loads these three files into the current R session.

The path parameter defaults to the current working directory.  The save.session function will create directories specified
using the path parameter unless they exist.

The version parameter in the save.session function defaults to a timestamp ("%y.%m%.%d.%H.%M") unless an alternative is specified.

Both save.session and load.session have verbose parameters which print session saving and loading progress messages respectively.

The force parameter in the save.session function will overwrite existing files.

The load.session function will add a sessionInfo<version> variable to the global environment.  This variable contains
the sessionInfo() string stored in the .RInfo file.


Further info:
```
?save.session
?load.session
```


## Roadmap

* Increase test coverage
* Make CRAN release
* Add meta data file (MData)
  * Check if loading a backup will overwrite existing data 
  * Summarise changes between backups


## Contributing
Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.


## License
[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
