# Anticipated Changes

* the data columns `'local.date'` and `'local.time'` will be renamed soon; 
please contact us if this is relevant to you.

* internal data storage will be changing; keeping your packages updated should 
make this nearly invisible to you if you access data via `powstreams`. But if 
you like to go straight to the ScienceBase website to download .tsv.gz files, 
please contact us.

* the exact format of `streamMetabolizer` models changes over time; keeping your
packages updated should make this nearly invisible to you

For update instructions, see 
https://github.com/aappling-usgs/powstreams/blob/master/README.md

# powstreams 0.7.19

* new functions: `search_sites`, `search_metab_models`, and `search_metab_runs`

* more powerful: `get_ts` aggregates sub-daily values to daily as needed

* more powerful: `get_ts_metadata` lets you do simple queries


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