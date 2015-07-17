
shinyUI(fluidPage(
  
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", label = "Sites to visualize", 
                  choices = get_types(),
                  selected = "alt", multiple = FALSE)
    ),
    mainPanel(
      leaflet::leafletOutput("mymap"),
  plotOutput("histogram")
    )
  )
))
