
noneselected = "-- no variable selected --"

library(shiny)
shinyServer(function(input, output, session) {
  
  
  
  output$Box1 = renderUI(
    if (is.null(input$site)){
      return()
    } else {
      all.datasets = unique(unlist(lapply(input$site,mda.streams::list_datasets)))
      selectizeInput("dataset1","Variables to visualize",
                     c(all.datasets, noneselected),
                     multiple = FALSE, selected=noneselected)
    }
  )
  
  output$Box2 = renderUI(
    if (is.null(input$dataset1) || input$dataset1 == noneselected){
        return()
    } else {
      all.datasets = unique(unlist(lapply(input$site,mda.streams::list_datasets)))
      selectInput("dataset2", label=NULL,
                       c(all.datasets[-which(all.datasets %in% input$dataset1)],noneselected),
                       multiple = FALSE, selected=noneselected)
    }
  )
  
  output$Box3 = renderUI(
    if (is.null(input$dataset2) || input$dataset2 == noneselected){
        return()
    } else {
      all.datasets = unique(unlist(lapply(input$site,mda.streams::list_datasets)))
      selectInput("dataset3", label=NULL,
                  c(all.datasets[-which(all.datasets %in% c(input$dataset1,input$dataset2))],noneselected),
                  multiple = FALSE, selected=noneselected)
    }
  )
  
  observeEvent(input$render, {
    output$Box4 <-renderText(paste(c(input$dataset1, input$dataset2, input$dataset3)))
  })
  
})