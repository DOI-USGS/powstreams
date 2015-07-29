library(dygraphs)
library(datasets)
library(powstreams)

shinyServer(function(input, output) {
  
  
  metabolism <- reactive({
    model <<- powstreams:::model # site-specific, run-specific model object
    u_i <- model@fit[c('minimum')] < input$min | is.na(model@fit[c('minimum')]) # keep the NAs to break up the plot
    data = model@fit[c('GPP','ER')]
    data[!u_i,] <- NA
    ts = xts::xts(x = data, order.by = as.POSIXct(model@fit$date))
    return(ts)
  })
  
  output$Box1 <- renderUI({
    # default to median of data
    sliderInput("min", "minimum threshold:", 
                min = min(model@fit[[c('minimum')]], na.rm=T), max = max(model@fit[[c('minimum')]], na.rm=T), 
                value = c(min(model@fit[[c('minimum')]], na.rm=T), floor(quantile(model@fit[[c('minimum')]], na.rm=T)[[3]])), step= 0.5)
  })
  
  
  
  k600 <- reactive({
    data = model@fit$K600
    u_i <- model@fit[c('minimum')] < input$min | is.na(model@fit[c('minimum')]) # keep the NAs to break up the plot
    data[!u_i] <- NA
    ts = xts::xts(x = data, order.by = as.POSIXct(model@fit$date)) %>% 
      setNames("K600")
    return(ts)
  })
  
#   k600 <- reactive({
#     ts = xts::xts(x = model@fit[c('K600')][u_i], order.by = as.POSIXct(model@fit$date))
#     return(ts)
#   })
  colors = RColorBrewer::brewer.pal(5, "Dark2")
  output$dygraph1 <- renderDygraph({
    dygraph(metabolism(), group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[1:2], drawPoints=TRUE, pointSize=4) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="Metabolism (units...)") %>%
      dySeries(c("GPP"), label = "Dsdfths") %>%
      dySeries(c("ER"), label = "Dsdf") 
  })
  output$dygraph2 <- renderDygraph({
    dygraph(k600(), group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[3], drawPoints=TRUE, pointSize=4) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="K600 (units...)") %>%
      dySeries(c("K600"), label = "Dsdfths")
  })
  output$dygraph3 <- renderDygraph({
    dygraph(k600(), group = "powstreams") %>%
      dygraphs::dyOptions(colors = colors[4], drawPoints=TRUE, pointSize=4) %>%
      dygraphs::dyHighlight(highlightSeriesBackgroundAlpha = 0.65, hideOnMouseOut = TRUE) %>%
      dygraphs::dyAxis('y', label="Metabolism (units...)") %>%
      dySeries(c("K600"), label = "Dsdfths")
  })
  
  plots <- reactive({
    u_i <- model@fit[c('minimum')] < input$min | is.na(model@fit[c('minimum')]) # keep the NAs to break up the plot
    par(mfcol=c(1,3))
    plot(model@fit[c('K600','ER')][u_i,])
    plot(model@fit[c('GPP','ER')][u_i,])
    plot(model@fit[c('K600','ER')][u_i,])
    
  })
  
  output$plot <- renderPlot({
    plots()
  })
  
})