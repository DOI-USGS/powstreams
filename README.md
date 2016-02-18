# powstreams

Tools for Powell Center working group on stream metabolism

## First-time installation
```r
install.packages("powstreams", dependencies = TRUE, 
  repos = c("http://owi.usgs.gov/R","https://cran.rstudio.com"))
```
## Updates (do this often after installation)
```r
update.packages(oldPkgs=c("powstreams","gsplot","mda.streams","sbtools","streamMetabolizer","unitted"),
  dependencies = TRUE, repos=c("http://owi.usgs.gov/R", "https://cran.rstudio.com"))
```

When you open a project in RStudio, R looks in the project directory for a file called `.RData` and automatically loads it into your R session. Sometimes the contents of this file interfere with package updates. If this is your situation, run `rm(list=ls(all=TRUE))` before trying updates (and please let me know if that doesn't fix it).

## Package Status

| Name       | Status |
| :------------ |:-------------|:-------------| 
| Linux Build: | [![master Build Status](https://travis-ci.org/USGS-R/powstreams.svg?branch=master)](https://travis-ci.org/USGS-R/powstreams/branches) |
| Windows Build: | [![master Build status](https://ci.appveyor.com/api/projects/status/gg6y017krc5ij0ba/branch/master?svg=true)](https://ci.appveyor.com/project/jread-usgs/powstreams/branch/master) |  
| Package Tests: | [![master Coverage Status](https://coveralls.io/repos/github/USGS-R/powstreams/badge.svg?branch=master)](https://coveralls.io/github/USGS-R/powstreams?branch=master) |  
| Priorities: | [![Issues Ready to Address](https://badge.waffle.io/USGS-R/powstreams.png?label=ready&title=Ready)](https://waffle.io/USGS-R/powstreams) [![Issues in Progress](https://badge.waffle.io/USGS-R/powstreams.png?label=In%20Progress&title=In%20Progress)](https://waffle.io/USGS-R/powstreams) |


## Disclaimer
This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the [official USGS copyright policy](http://www.usgs.gov/visual-id/credit_usgs.html#copyright/ "official USGS copyright policy")

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."
