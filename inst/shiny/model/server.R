library(dygraphs)
library(datasets)
library(DT)
library(streamMetabolizer)
library(powstreams)
library(dplyr)
library(unitted)
library(plotly)

noneselected <- "-- no variable selected --"
metab_models <- dplyr::add_rownames(mda.streams::parse_metab_model_name(mda.streams::list_metab_models()),'model_name') %>% as.data.frame()
empty.xts <- setNames(xts::xts(c(NA,NA), order.by=as.POSIXct(c('2012-01-01','2012-01-02'))), "none")
null.xts <- empty.xts[c(),]
models <<- list()

shinyServer(function(input, output) {
  
  # <---input reactive--->
  react_model_data <- reactive({
    if (length(input$x1_rows_selected)>0)
      get_model_data()
    else
      models <<- list()
    return()
  })
  # </---input reactive--->
  
  # <---helpers--->
  get_model_data <- function(){
    for (row in input$x1_rows_selected){
      r.chr <- metab_models[row, 'model_name']
      if (is.null(names(models)) || !(r.chr %in% names(models))) {
        file = download_metab_model(r.chr, on_local_exists = 'skip')
        if (file.size(file) > 0){
          varname <- load(file) # site-specific, run-specific model object
          models[[r.chr]] <- mda.streams::modernize_metab_model(get(varname))
        } else {
          models[[r.chr]] <- list() # empty model
        }
      } # // else: skip it, because it is already in the list
    }
    rmv.nm <- names(models)[!names(models) %in% metab_models[input$x1_rows_selected, 'model_name']]
    # remove all models that aren't selected 
    for (nm in rmv.nm){
      models[[nm]] <- NULL
    }
    models <<- models
    return()
  }
  
  merge_extract <- function(var){
    if (is.null(names(models))){
      return(empty.xts)
    } else {
      ts.out <- null.xts
      for (nm in names(models)){
        pnm <- parse_metab_model_name(metab_models[nm,'model_name'])
        model_tag <- paste(pnm$site, pnm$tag, pnm$row, sep='_')
        vardat <- predict_metab(models[[nm]])
        if(nrow(vardat) > 0) {
          vardat <- vardat[c('local.date',grep(var, names(vardat), value=TRUE))]
          if(nrow(vardat) == 1) {
            vardat <- data.frame(
              dt=vardat[[1,1]] + as.difftime(i+c(-1,4), units="secs"), 
              vardat[1,-1]) %>% setNames(names(vardat))
          }
          df <- data.frame(xts::xts(vardat[[var]], order.by=vardat[['local.date']])) %>% setNames(model_tag)
        } else {
          df <- null.xts
        }
        ts.out <- merge(ts.out, df)
      }
      if(length(ts.out) == 0) ts.out <- empty.xts
      return(ts.out)
    }
  }
  
  buildDy <- function(var, label){
    react_model_data()
    data <- merge_extract(var)
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label=label)
  }
  # </---helpers--->
  
  # <--- viz components --->
  output$x1 = DT::renderDataTable(
    metab_models[,c(4,5,6,3,7)], server = FALSE, rownames=FALSE,
    options=list(pageLength=15, order=list(list(1,'desc'))))
  colors = RColorBrewer::brewer.pal(5, "Dark2")
  output$dygraph1 <- renderDygraph({
    buildDy("GPP", "GPP (g m^-2 d^-1)")
  })
  output$dygraph2 <- renderDygraph({
    buildDy("ER", "ER (g m^-2 d^-1)")
  })
  output$dygraph3 <- renderDygraph({
    buildDy("K600", "K600 (d^-1)")
  })
  
  # </--- viz components --->
  observeEvent(input$kill,{
    stopApp()
  })
  regression_data <- reactive({
    react_model_data()
    dplyr::bind_rows(lapply(names(models), function(nm) {
      m <- models[[nm]]
      preds <- predict_metab(m)
      if(nrow(preds)==0) preds <- data.frame(local.date=NA, GPP=NA, ER=NA, K600=NA)
      site <- get_info(m)$config$site
      coords <- get_site_info(site)
      amps <- tryCatch(
        get_ts("doamp_calcDAmp", site) %>% unitted::v() %>%
          mutate(local.date=as.Date(convert_GMT_to_solartime(DateTime, longitude=coords$lon))) %>%
          select(local.date, doamp), 
        error=function(e) data.frame(local.date=preds$local.date, doamp=NA))
      data.frame(model=nm, dplyr::full_join(preds, amps, by="local.date"), stringsAsFactors=FALSE)
    }))
  })
  buildReg <- function(reg_data, xvar, yvar) {
    if(nrow(reg_data)==0) return()
    plot_ly(reg_data, x=reg_data[[xvar]], y=reg_data[[yvar]], type='scatter', color=model, mode='markers', opacity=0.8,
            text=sprintf('%s<br>%s<br>%s = %0.1f<br>%s = %0.1f', model, as.character(local.date), xvar, reg_data[[xvar]], yvar, reg_data[[yvar]]), 
            hoverinfo='text+x') %>%
      layout(xaxis=list(title=xvar), yaxis=list(title=ifelse(yvar=='doamp', 'Daily amplitude of DO (% sat)', yvar)))
  }
  output$regplot_tl <- renderPlotly({ 
    buildReg(regression_data(), 'GPP', 'doamp')
  })
  output$regplot_tr <- renderPlotly({ 
    buildReg(regression_data(), 'ER', 'GPP')
  })
  output$regplot_bl <- renderPlotly({ 
    buildReg(regression_data(), 'GPP', 'K600')
  })
  output$regplot_br <- renderPlotly({ 
    buildReg(regression_data(), 'ER', 'K600')
  })
  
})