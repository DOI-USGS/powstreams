library(shiny)
library(leaflet)
source('helpers.R')
r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()


shinyUI(fluidPage(
  
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", label = "Sites to visualize", 
                  choices = get_types(),
                  selected = "alt", multiple = FALSE)
    ),
    mainPanel(
      leafletOutput("mymap"),
  plotOutput("histogram")
    )
  )
))
