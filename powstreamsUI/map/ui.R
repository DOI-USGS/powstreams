library(shiny)
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

shinyUI(fluidPage(
  
  titlePanel("Powstreams working group"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", label = "Sites to visualize", 
                  choices = names(mda.streams::get_meta(types = c("basic"))),
                  selected = "alt", multiple = FALSE),
      actionButton("recalc", "Submit")
    ),
    mainPanel(
      leafletOutput("mymap"),
  plotOutput("histogram"), 
  p()
    )
  )
))
