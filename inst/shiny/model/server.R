library(dygraphs)
library(datasets)
library(DT)
library(streamMetabolizer)
library(mda.streams)
library(powstreams)
library(dplyr)
library(unitted)
library(plotly)
library(RColorBrewer)

message("downloading model list")
metab_models <<- dplyr::add_rownames(mda.streams::parse_metab_model_name(mda.streams::list_metab_models()),'model_name') %>% 
  mutate(tag=as.character(tag)) %>% as.data.frame() # nothing but numbers and letters allowed here!
noneselected <- "-- no variable selected --"
empty.xts <- setNames(xts::xts(c(NA,NA), order.by=as.POSIXct(c('2012-01-01','2012-01-02'))), "none")
null.xts <- empty.xts[c(),]
models <<- list() # make available in R after app quits
model_tags <- list()

shinyServer(function(input, output) {
  
  # <--- get model data --->
  react_model_data <- reactive({
    message("updating model data")
    if (length(input$model_list_rows_selected)>0) {
      get_model_data()
      get_model_tags()
    } else {
      models <<- list()
      model_tags <<- list()
    }
    return()
  })
  get_model_data <- function(){
    message("retrieving model data")
    for (row in input$model_list_rows_selected){
      model_name <- metab_models[row, 'model_name']
      if (is.null(names(models)) || !(model_name %in% names(models))) {
        message("  loading model: ", model_name)
        model_path <- make_metab_model_path(model_name, folder=tempdir())
        if(!file.exists(model_path)) {
          mm <- get_metab_model(model_name, on_local_exists = 'skip', version='modern', update_sb=FALSE)
          suppressWarnings(stage_metab_model(title=parse_metab_model_name(model_name, out='title'), metab_outs=list(mm), verbose=FALSE))
        } else {
          mm <- get(load(model_path))
        }
        models[[model_name]] <- mm
      } # else: skip it, because it is already in the list
    }
    rmv.nm <- names(models)[!names(models) %in% metab_models[input$model_list_rows_selected, 'model_name']]
    # remove all models that aren't selected 
    for (nm in rmv.nm){
      models[[nm]] <- NULL
    }
    models <<- models
    return()
  }
  get_model_tags <- function() {
    message("setting model tags")
    pnm <- parse_metab_model_name(names(models))
    model_tags <<- paste(pnm$site, pnm$tag, pnm$row, sep='_') %>% setNames(names(models))
  }
  # </--- get model data --->
  
  # <--- table helpers --->
  buildDT <- function() {
    message("building models table")
    metab_models[,c(4,5,6,3,7)]
  }
  # </--- table helpers --->
  
  # <--- time series helpers --->
  colors <- RColorBrewer::brewer.pal(5, "Dark2")
  buildDy <- function(var, label){
    "building dygraph plot"
    react_model_data()
    data <- merge_extract(var)
    dygraphs::dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label=label)
  }
  merge_extract <- function(var){
    message("building timeseries for ", var)
    if (is.null(names(models))){
      return(empty.xts)
    } else {
      ts.out <- null.xts
      for (nm in names(models)){
        vardat <- predict_metab(models[[nm]])
        if(nrow(vardat) > 0) {
          vardat <- vardat[c('local.date',grep(var, names(vardat), value=TRUE))]
          if(nrow(vardat) == 1) {
            vardat <- data.frame(
              dt=vardat[[1,1]] + as.difftime(i+c(-1,4), units="secs"), 
              vardat[1,-1]) %>% setNames(names(vardat))
          }
          df <- data.frame(xts::xts(vardat[[var]], order.by=vardat[['local.date']])) %>% setNames(model_tags[nm])
        } else {
          df <- null.xts
        }
        ts.out <- merge(ts.out, df)
      }
      if(length(ts.out) == 0) ts.out <- empty.xts
      return(ts.out)
    }
  }
  # </--- time series helpers --->
  
  # <--- regression helpers --->
  regression_data <- reactive({
    message("building regression data")
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
      data.frame(model=nm, model_tag=model_tags[nm], dplyr::full_join(preds, amps, by="local.date"), stringsAsFactors=FALSE)
    }))
  })
  buildReg <- function(reg_data, xvar, yvar) {
    message("building regression plot")
    rownames(reg_data) <- NULL
    reg_data <- reg_data[complete.cases(reg_data[c(xvar,yvar)]),]
    if(nrow(reg_data)==0) return()
    axisunits <- unique(get_var_src_codes(out=c('var','units'))) %>% .[match(tolower(c(xvar,yvar)), tolower(.$var)),'units']
    axislabs <- paste0(c(doamp='Daily amplitude of DO', GPP='GPP', ER='ER', K600='K600')[c(xvar,yvar)], ' (', axisunits, ')')
    plot_ly(reg_data, x=reg_data[[xvar]], y=reg_data[[yvar]], type='scatter', color=model, mode='markers', opacity=0.8,
            colors = colors[seq_len(length(unique(reg_data$model)))],
            text=sprintf('%s<br>%s<br>%s = %0.1f<br>%s = %0.1f', model_tag, as.character(local.date), xvar, reg_data[[xvar]], yvar, reg_data[[yvar]]), 
            hoverinfo='text+x') %>%
      layout(xaxis=list(title=axislabs[1]), yaxis=list(title=axislabs[2]))
  }
  # </--- regression helpers --->
  
  # <--- summary helpers --->
  summary_data <- reactive({
    message("building model summary")
    react_model_data()
    if(length(models) > 0) {
      mda.streams::summarize_metab_model(models) %>%
        v() %>% mutate(tag=as.character(tag))
    } else {
      data.frame()
    }
  })
  # </--- summary helpers --->
  
  # <--- viz components --->
  # model list
  output$model_list <- DT::renderDataTable(
    buildDT(), server = FALSE, rownames=FALSE,
    options=list(pageLength=15, order=list(list(1,'desc'))))
  # buttons
  observeEvent(input$kill,{
    stopApp()
  })
  # estimates
  output$dygraph1 <- renderDygraph({
    buildDy("GPP", "GPP (g m^-2 d^-1)")
  })
  output$dygraph2 <- renderDygraph({
    buildDy("ER", "ER (g m^-2 d^-1)")
  })
  output$dygraph3 <- renderDygraph({
    buildDy("K600", "K600 (d^-1)")
  })
  # regressions
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
  # summary
  output$summary = DT::renderDataTable(
    summary_data(), server=FALSE, rownames=FALSE,
    options=list(pageLenght=15)
  )
  # </--- viz components --->
  
})