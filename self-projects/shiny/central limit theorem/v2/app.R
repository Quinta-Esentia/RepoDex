# Central Limit Theorem App
library(shiny)
library(tidyverse)
source("sample_dist_function.R", local = TRUE)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
##### ui ####
ui <- shinyUI(
  pageWithSidebar(
    headerPanel("CLT & the Sampling Distribution of the Mean"),
    
    sidebarPanel(
      selectInput("Distribution", "Please Select Distribution Type",
                  choices = c("Gaussian", "Exponential", "Chi Squared", "Uniform")),
      sliderInput("sampleSize", "Please Select Sample Size: ",
                  min = 1, max = 60, value = 1, step = 1),
      textInput("sampleNumber", "Select Number of Samples", 1000),
      textInput("populationSize", "Select Population Size", 5000),
      
    ), 
    
    mainPanel(
      plotOutput("myPlot")
    )
  )
)






# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
##### Server ####
server <- shinyServer(
  function(input, output){
    
    output$myPlot <- renderPlot({
      
      # Set up Input Variables
      distType <- input$Distribution
      N_pop <- input$populationSize
      n_samp <- input$sampleNumber
      size_samp <- input$sampleSize
      normal_mean <- input$mean
      
      # ### Conditional Options for Different Distributions
      # if(distType == "Normal"){
      #   
      #   randomVec <- rnorm(size_samp, mean = as.numeric(normal_mean), sd = as.numeric(normal_mean))
      # }
      # else{
      #   
      #   randomVec <- rexp(size_samp, rate = 1/as.numeric(input$lambda))
      # }
      
      sample_from_pop(distType, N_pop, n_samp, size_samp)
      
      # # Plot the thing
      # 
      # # hist(randomVec, col = 'blue')
      # # plot(density(randomVec), col = 'blue')
      # ggplot(data.frame(randomVec), aes(x=randomVec)) +
      #   geom_histogram(aes(y=..density..), 
      #                  bins = 30,
      #                  fill = "white", colour = "black",
      #                  position = "identity", alpha = 0.5) +
      #   geom_density(alpha = 0.5, size = 2, colour = 'blue') + 
      #   xlab("x") +
      #   theme_classic()
    })
    
    
    
    
  }
  
  
)





# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#  
#### Run the App ####
shinyApp(ui,server)