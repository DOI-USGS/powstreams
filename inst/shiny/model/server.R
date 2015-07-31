library(dygraphs)
library(datasets)
library(DT)
library(powstreams)

noneselected = "-- no variable selected --"
metab_models = dplyr::add_rownames(mda.streams::parse_metab_model_name(mda.streams::list_metab_models()),'model_name') %>% as.data.frame()
empty.xts <- data.frame('NA'=xts::xts(c(NA,NA), order.by=as.POSIXct(c('2012-01-01','2012-01-02'))))
null.xts <- xts::xts(NULL)
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
      r.chr <- as.character(row)
      if (is.null(names(models)) || !names(models) %in% r.chr){
        file = download_metab_model(metab_models[row, ]$model_name, on_local_exists = 'skip')
        if (file.size(file) > 0){
          load(file) # site-specific, run-specific model object
          models[[r.chr]] <- mm
        } else {
          models[[r.chr]] <- list() # empty model
        }
      } # // else: skip it, because it is already in the list
    }
    rmv.nm <- names(models)[!names(models) %in% as.character(input$x1_rows_selected)]
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
        df <- data.frame(xts::xts(models[[nm]]@fit[[var]], order.by=models[[nm]]@fit[['date']])) %>% 
          setNames(paste(var,models[[nm]]@info$site, models[[nm]]@info$strategy, models[[nm]]@info$tag, sep='.'))
        ts.out <- merge(ts.out, df)
      }
      return(ts.out)
    }
  }
  
  buildDy <- function(var, label){
    react_model_data()
    data = merge_extract(var)
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label=label)
  }
  # </---helpers--->
  
  # <--- viz components --->
  output$x1 = DT::renderDataTable(metab_models[,c(-1,-2)], server = FALSE, rownames=FALSE, #filter='top',
                                  options=list(pageLength=15,
                                               order=list(list(2,'desc'))))
  colors = RColorBrewer::brewer.pal(5, "Dark2")
  output$dygraph1 <- renderDygraph({
    buildDy("GPP",'GPP (g m^-2 d^-1)')
  })
  output$dygraph2 <- renderDygraph({
    buildDy("ER","ER (g m^-2 d^-1)")
  })
  output$dygraph3 <- renderDygraph({
    buildDy("K600", "K600 (d^-1)")
  })
  # </--- viz components --->
  observeEvent(input$kill,{
    stopApp()
  })
  plots <- reactive({ 
    react_model_data()
    
    
    plots.list <- list(list(x='K600',y='ER'), list(x='GPP',y='ER'), list(x='GPP',y='K600'))
    layout(matrix(c(1:length(plots.list)),nrow=1))
    par(pty="s",mar=c(3.5,3.5,0.5,0.5))
    for (p in seq_len(length(plots.list))){
      gs <- gsplot::gsplot()
      if (!is.null(names(models))){
        for (i in seq_len(length(names(models)))){
          x <- models[[i]]@fit[[plots.list[[p]]$x]]
          y <- models[[i]]@fit[[plots.list[[p]]$y]]
          if(any(is.null(c(x,y)))){
            x = y = NA
          }
          gs <- gsplot::points(gs, x, y,
                               col=colors[i], ylab=plots.list[[p]]$y,xlab=plots.list[[p]]$x)
        }
      } else {
        gs <- gsplot::points(gs, c(1,NA),c(NA,1), ylab=plots.list[[p]]$y,xlab=plots.list[[p]]$x)
      }
      print(gs)
    }
  })
  
  output$plot <- renderPlot({
    plots()
  })
  
})