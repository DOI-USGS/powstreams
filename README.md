powstreams
==========

Tools for Powell Center working group on stream metabolism

[![Windows Build status](https://ci.appveyor.com/api/projects/status/gg6y017krc5ij0ba?svg=true)](https://ci.appveyor.com/project/jread-usgs/powstreams)
[![Linux Build Status](https://travis-ci.org/USGS-R/powstreams.svg)](https://travis-ci.org/USGS-R/powstreams)
[![Test Coverage Status](https://img.shields.io/coveralls/USGS-R/powstreams.svg)](https://coveralls.io/r/USGS-R/powstreams)
[![Issues Ready to Address](https://badge.waffle.io/USGS-R/powstreams.png?label=ready&title=Ready)](https://waffle.io/USGS-R/powstreams)

### First-time installation:
```r
install.packages("powstreams", dependencies = TRUE, 
  repos = c("http://owi.usgs.gov/R","https://cran.rstudio.com"))
```
### Updates (do this often after installation):
```r
update.packages(oldPkgs=c("powstreams","mda.streams","streamMetabolizer","sbtools","unitted"),
  dependencies = TRUE, repos=c("http://owi.usgs.gov/R", "https://cran.rstudio.com"))
```

## Disclaimer
This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the [official USGS copyright policy](http://www.usgs.gov/visual-id/credit_usgs.html#copyright/ "official USGS copyright policy")

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."
