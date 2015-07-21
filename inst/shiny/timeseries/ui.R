library(dygraphs)

shinyUI(fluidPage(
  
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("site", label = "Sites to visualize", 
                  choices = mda.streams::get_sites(),
                  selected = "nwis_06893820", multiple = TRUE),
      selectInput("dataset", label = "Timeseries dataset",
                  choices = c("baro_nldas", "wtr_nwis", "doobs_nwis", "disch_nwis","stage_nwis","dosat_calcGGbts",
                              "er_estDOMLEPRK","K600_estDOMLEPRK","gpp_estDOMLEPRK"),
                  selected = "doobs_nwis", multiple = TRUE),
      submitButton("Submit")
    ),
    mainPanel(
      dygraphOutput("dygraph1"),
      dygraphOutput("dygraph2"),
      dygraphOutput("dygraph3")
    )
  )
))