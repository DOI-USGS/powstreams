devtools::install_github(c("USGS-R/mda.streams", "appling/unitted","USGS-R/dataRetrieval","USGS-R/streamMetabolizer","USGS-R/geoknife","USGS-R/powstreams"))
rsconnect::deployApp('inst/shiny/timeseries', appName='pow_timeseries')
rsconnect::deployApp('inst/shiny/map', appName='pow_map')
