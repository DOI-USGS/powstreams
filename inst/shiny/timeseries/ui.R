library(dygraphs)
initial.site = "nwis_06893820"
initial.var = "doobs_nwis"

shinyUI(fluidPage(
  
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("site", label = "Sites to visualize", 
                  choices = mda.streams::list_sites(),
                  selected = initial.site, multiple = TRUE),
      selectizeInput("dataset", label = "Timeseries dataset",
                  choices = mda.streams::list_datasets(initial.site),
                  selected = initial.var, multiple = TRUE, options = list(maxItems = 3)),
      submitButton("Submit")
    ),
    mainPanel(
      dygraphOutput("dygraph1"),
      dygraphOutput("dygraph2"),
      dygraphOutput("dygraph3")
    )
  )
))