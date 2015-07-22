
initial.site = "nwis_06893820"

sites.list <- mda.streams::list_sites()
library(shiny)
library(dygraphs)
shinyUI(fluidPage(
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("site", label = "Sites to visualize", 
                                     choices = sites.list,
                                     selected = initial.site, multiple = TRUE),
      uiOutput("Box1"),
      uiOutput("Box2"),
      uiOutput("Box3"),
      actionButton("render", "Render visuals")
      
    ),
    mainPanel("Display results",
              uiOutput("Box4"),
              dygraphOutput("dygraph1"),
              dygraphOutput("dygraph2"),
              dygraphOutput("dygraph3")
  )
)))