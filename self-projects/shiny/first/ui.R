library(shiny)
library(ggplot2)

shinyUI(
  pageWithSidebar(
    headerPanel("Dexter's First Shiny App"),
    
    sidebarPanel(
      selectInput("Distribution", "Please Select Distribution Type",
                  choices = c("Normal", "Exponential")),
      sliderInput("sampleSize", "Please Select Sample Size: ",
                  min = 10, max = 2000, value = 100, step = 10),
      conditionalPanel(condition = "input.Distribution == 'Normal'",
                       textInput("mean", "Please Select the mean", 10),
                       textInput("sd", "Please Select Standard Deviation", 3)),
      conditionalPanel(condition = "input.Distribution == 'Exponential'",
                       textInput("lambda", "Please Select Exponential Lambda: ", 1))
    ), 
    
    mainPanel(
      plotOutput("myPlot")
    )
  )
)