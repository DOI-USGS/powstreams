library(powstreams)
library(dplyr)
library(dinosvg)
library(XML)
# calculated the monthly median max-min for DO for each site
sites <- list_sites(c('doobs','wtr','disch'))

base_df <- data.frame('site'=NA, 'March'=NA,'April'=NA,'May'=NA,'June'=NA,
                      'July'=NA,'August'=NA,'September'=NA,'October'=NA,'November'=NA,
                      'December'=NA,'January'=NA,'February'=NA)
rng <- function(values){
  return(diff(range(values,na.rm=T)))
}
for (i in 1:length(sites)){
  data = base_df
  df <- load_timeseries(sites[i],'doobs')
  df <- cbind(df, data.frame('jday'=as.Date(df[,1])))
  
  jul_rng <- df %>% group_by(jday) %>% summarize(range = rng(ts_doobs)) %>% mutate(months = months(jday))
  mon_med  = jul_rng %>% group_by(months) %>% summarize(med = median(range,na.rm=T))
  data[mon_med$months] = mon_med$med
  data$site <- sites[i]
  if (i == 1){
    amps <- data
  } else {
    amps <- rbind(amps, data)
  }
  
  cat('done with ',sites[i],'.\n**',i,' of ',length(sites),'\n')
}


trips <- amps[, -1]
rpl_i <- trips==-Inf | trips==Inf
trips[rpl_i] = NA

bp <- boxplot(trips, las = 2, ylab = 'Variable (?/L)', plot = T)
y_ticks <- axTicks(2)
y_lim <- par()$usr[c(3, 4)]
x_lim <- par()$usr[c(1, 2)] # note first marker is on 1, incrementing as int
dev.off()
# --- pixel dims ---
axes <- list('tick_len' = 5,
             'y_label' = "DO daily range (mg -L)",
             'y_ticks' = y_ticks,
             'y_tk_label' = y_ticks,
             'x_ticks' = seq_len(length(trips)),
             'x_tk_label' = names(trips),
             'y_lim' = y_lim,
             'x_lim' = x_lim)

fig <- list('w' = 950,
            'h' = 850,
            'margins' = c(100,80,10,90)) #bot, left, top, right

fig$px_lim <- list("x" = c(fig$margins[2], fig$w-fig$margins[2]-fig$margins[4]),
                   "y" = c(fig$h-fig$margins[3]-fig$margins[1], fig$margins[3]))

boxes <- list('width' = 0.65,
              'rat_whisker' = 0.6, # ratio of whisker to box width
              'def_opacity' = 0.5)



g_id <- svg_init(fig, boxes$def_opacity)
add_axes(g_id, axes, fig)


# for one trip:
for (i in 1:length(trips)){
  
  add_boxwhisk(g_id, y_stats = bp$stats[, i], y_data = trips[,i], x_val = i, box_id = i, axes, fig, boxes, sites = amps[, 1])
  
}


newXMLNode("rect", parent = g_id, newXMLTextNode('Tooltip'),
           attrs = c(class="label", id="tooltip_bg", x="0", y="0", rx="4", ry="4", 
                     width="55", height="28", style="fill:#f6f6f6;fill-opacity:0.85;stroke:#696969;stroke-width:0.5;",
                     visibility="hidden"))

newXMLNode("text", parent = g_id, newXMLTextNode('Tooltip'),
           attrs = c(class="label", id="tooltip", x="0", y="0", 
                     visibility="hidden"))

root_nd <- xmlRoot(g_id)

saveXML(root_nd, file = './powstreams_amps.svg')