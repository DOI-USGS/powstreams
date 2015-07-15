library(dygraphs)

shinyUI(fluidPage(
  
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("site", label = "Sites to visualize", 
                  choices = c("nwis_06893820","nwis_50048565", "nwis_01648010", "nwis_03039040", "nwis_07060000"),
                  selected = "nwis_06893820"),
      selectInput("dataset", label = "Timeseries dataset",
                  choices = c("baro_nldas", "wtr_nwis", "doobs_nwis", "disch_nwis"),
                  selected = "doobs_nwis", multiple = TRUE),
      submitButton("Submit")
    ),
    mainPanel(

     verbatimTextOutput("text"),
  
      dygraphOutput("dygraph1"),
      dygraphOutput("dygraph2"),
      dygraphOutput("dygraph3")
    )
  )
))