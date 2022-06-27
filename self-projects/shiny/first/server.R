library(shiny)
library(ggplot2)

shinyServer(
  function(input, output, session){
    
    output$myPlot <- renderPlot({
      
      distType <- input$Distribution
      size <- input$sampleSize
      
      if(distType == "Normal"){
        
        randomVec <- rnorm(size, mean = as.numeric(input$mean), sd = as.numeric(input$sd))
      }
      else{
      
        randomVec <- rexp(size, rate = 1/as.numeric(input$lambda))
      }
      
      # hist(randomVec, col = 'blue')
      # plot(density(randomVec), col = 'blue')
      ggplot(data.frame(randomVec), aes(x=randomVec)) +
        geom_histogram(aes(y=..density..), 
                       bins = 30,
                       fill = "white", colour = "black",
                       position = "identity", alpha = 0.5) +
        geom_density(alpha = 0.5, size = 2, colour = 'blue') + 
        xlab("x") +
        theme_classic()
    })
    
    
    
    
  }
  
  
)