library(dygraphs)
library(datasets)
library(DT)
library(powstreams)
metab_models = add_rownames(parse_metab_model_name(list_metab_models()),'model_name') %>% as.data.frame()


shinyServer(function(input, output) {
  
  
  get_model_data <- reactive({
  
    ts.out <- list(GPP=xts::xts(NULL), ER=xts::xts(NULL), K600=xts::xts(NULL))
    if (length(input$x1_rows_selected)>0){
      for (row in input$x1_rows_selected){
        file = download_metab_model(metab_models[row, ]$model_name, on_local_exists = 'skip')
        if (file.size(file) > 0){
          load(file) # site-specific, run-specific model object
          for (i in names(ts.out)){
            val <- data.frame(xts::xts(x = mm@fit[[i]], order.by = as.POSIXct(mm@fit$date)))
            val = setNames(val, metab_models[row, ]$model_name)
            ts.out[[i]] = merge(ts.out[[i]], val)
          }
        } else {
          for (i in names(ts.out)){
            val <- xts::xts(c(NA,NA), order.by = as.POSIXct(c('2011-01-01','2011-01-02')))
            setNames(val, metab_models[row, ]$model_name)
            ts.out[[i]] = merge(ts.out[[i]], val)
            
          }
        }
        
      }
    } else { # // nothing selected
      ox = xts::xts(c(NA,NA), order.by = as.POSIXct(c('2011-01-01','2011-01-02')))
      for (i in names(ts.out)){
        ts.out[[i]] = data.frame(ox)
        names(ts.out[[i]]) <- i
      }
    }
    
    return(ts.out)
  })
  
  
  output$x1 = DT::renderDataTable(metab_models[,c(-1,-2)], server = FALSE, rownames=FALSE, #filter='top',
                                  options=list(pageLength=15,
                                               order=list(list(2,'desc'))))
  
  # highlight selected rows in the scatterplot
  output$x2 = renderPlot({
    s = input$x1_rows_selected
    par(mar = c(4, 4, 1, .1))
    plot(cars)
    if (length(s)) points(cars[s, , drop = FALSE], pch = 19, cex = 2)
  })
  
  
  output$Box1 <- renderUI({
    # default to median of data
    sliderInput("min", "minimum threshold:", 
                min = min(model@fit[[c('r.squared')]], na.rm=T), max = max(model@fit[[c('r.squared')]], na.rm=T), 
                value = c(min(model@fit[[c('r.squared')]], na.rm=T), floor(quantile(model@fit[[c('r.squared')]], na.rm=T)[[3]])), step= 0.05)
  })
  

  
  colors = RColorBrewer::brewer.pal(5, "Dark2")
  output$dygraph1 <- renderDygraph({
    data = get_model_data()[["GPP"]]
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="Metabolism (units...)")
  })
  output$dygraph2 <- renderDygraph({
    data = get_model_data()[["ER"]]
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="Metabolism (units...)")
  })
  output$dygraph3 <- renderDygraph({
    data = get_model_data()[["K600"]]
    dygraph(data, group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[seq_len(ncol(data))], drawPoints=TRUE, pointSize=2) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="K600 (units...)") 
  })
  
  plots <- reactive({
    data = get_model_data()
    #u_i <- model@fit[c('minimum')] < input$min | is.na(model@fit[c('minimum')]) # keep the NAs to break up the plot
    par(mfcol=c(1,3))
    plot(as.numeric(data$K600[,1]), as.numeric(data$ER[,1]), col=colors[1], asp=1)
    if (ncol(data$K600)>1){
      for (i in seq_len(ncol(data$K600))[-1]){
        points(as.numeric(data$K600[,i]), as.numeric(data$ER[,i]), col=colors[i])
      }
    }
    plot(as.numeric(data$GPP[,1]), as.numeric(data$ER[,1]), col=colors[1], asp=1)
    if (ncol(data$GPP)>1){
      for (i in seq_len(ncol(data$GPP))[-1]){
        points(as.numeric(data$GPP[,i]), as.numeric(data$ER[,i]), col=colors[i])
      }
    }
    plot(as.numeric(data$K600[,1]), as.numeric(data$ER[,1]), col=colors[1], asp=1)
    if (ncol(data$K600)>1){
      for (i in seq_len(ncol(data$K600))[-1]){
        points(as.numeric(data$K600[,i]), as.numeric(data$ER[,i]), col=colors[i])
      }
    }
  })
  
  output$plot <- renderPlot({
    plots()
  })
  
})