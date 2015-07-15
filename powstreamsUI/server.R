library(mda.streams)
library(dygraphs)
library(unitted)
library(magrittr)
library(xts)


shinyServer(function(input, output) {
  
  downloaded <- function(i){
    
    if (i <= length(input$dataset)){
      file <- download_ts(var_src = input$dataset[i], site_name = input$site, on_local_exists = 'skip')
      var <- v(read_ts(file))
      
      xts(var[[2]], order.by = as.POSIXct(var[['DateTime']]), tz='UTC')
    } else {
      NULL
    }# // else do nothing
    
  }
  

  output$text <- renderText({
    paste("download file is:", input$dataset)
  })
  
  output[['dygraph1']] <- renderDygraph({
    i = 1
    ts <- downloaded(i)
    dygraph(ts, main = paste0(input$site,': ',input$dataset[i]), group = "powstreams") %>%
      dySeries(label = input$dataset[i]) %>%
      dyAxis("y", label = "Discoveries / Year")
  })
  output[['dygraph2']] <- renderDygraph({
    i = 2
    ts <- downloaded(i)
    if (!is.null(ts)){
      dygraph(ts, main = paste0(input$site,': ',input$dataset[i]), group = "powstreams") %>%
        dySeries(label = input$dataset[i])
    }
  })
  output[['dygraph3']] <- renderDygraph({
    i = 3
    ts <- downloaded(i)
    if (!is.null(ts)){
      dygraph(ts, main = paste0(input$site,': ',input$dataset[i]), group = "powstreams") %>%
        dySeries(label = input$dataset[i])
    }
  })
})