# Installation and Updates

For instructions on how to install or update `powstreams`, see 
https://github.com/aappling-usgs/powstreams/blob/master/README.md

# powstreams 0.7.19

* new functions: `search_sites`, `search_ts_metadata`, `search_metab_models`, 
and `search_metab_runs`

* more powerful: `get_ts` aggregates sub-daily values to daily as needed

* interface change: the data columns `'local.date'` and `'local.time'` have been
renamed to `date` and `solar.time`, respectively.

* our backstage data storage methods (both local and on ScienceBase) have 
changed to bring you faster performance, more detailed data


# powstreams 0.7.18

As of version 0.7.18, `powstreams` is good at:

* exploring time series data and model outputs in a browser

* getting data from ScienceBase into R for analysis

* getting information about sites

* exporting data from R to text files on your computer

* locating data pages on the ScienceBase website



# Other Changes

The `powstreams` package depends on the `mda.streams` and `streamMetabolizer` 
packages. View NEWS for those packages at 
https://github.com/USGS-R/mda.streams/blob/develop/NEWS.md and 
https://github.com/USGS-R/streamMetabolizer/blob/develop/NEWS.md, respectively.