# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Coronavirus App

library(deSolve)
library(tidyverse)

#### Create the system of ordinary differential equations ####
closed.sir.model <- function (t, x, params) {
  ## first extract the state variables
  S <- x[1] # Susceptible 
  I <- x[2] # Infected
  R <- x[3] # Removed (Recovered / Dead)
  ## now extract the parameters
  transm <- params["transm"] # transmission rate
  recov <- params["recov"] # recovery rate
  N <- S+I+R
  ## now code the model equations:
  ## A system of 3 ordinary diffenential equations
  dSdt <- -transm*S*I 
  dIdt <- transm*S*I - recov*I
  dRdt <- recov*I
  ## combine results into a single vector
  dxdt <- c(dSdt,dIdt,dRdt)
  ## return result as a list!
  list(dxdt)
}



#### ui ####
ui <- shinyUI(
  pageWithSidebar(
    headerPanel("Coronavirus Curve"),
    
    sidebarPanel(
      sliderInput("Transmission_Rate", "Select Transmission Rate: ",
                  min = 0, max = 5, value = 3.2, step = 0.1),
      sliderInput("Recovery_Rate", "Select Recovery Rate: ",
                  min = 0, max = 5, value = 0.23, step = 0.02),
      sliderInput("maxT", "Select Runtime: ",
                  min = 0, max = 100, value = 40, step = 10),
    ), 
    
    mainPanel(
      plotOutput("curve")
    )
  )
)

#### Server ####

server <- shinyServer(
  function(input, output){
    
    output$curve <- renderPlot({
      
      Transmission_Rate <- input$Transmission_Rate
      Recovery_Rate <- input$Recovery_Rate
      maxT <- input$maxT
      
      
      parms <- c(transm = Transmission_Rate, recov = Recovery_Rate)
      times <- seq(from = 0,to = maxT, by = 1/10)
      xstart <- c(Susceptible = 0.99, Infected = 0.01, Removed = 0)
      
      out <- ode(
        func=closed.sir.model,
        y=xstart,
        times=times,
        parms=parms
      ) %>%
        as.data.frame()
      
      transm_lab <- paste("Transmission Rate = ",Transmission_Rate)
      recov_lab <- paste("Recovery Rate = ",Recovery_Rate)
      out %>%
        gather(variable,value,-time) %>%
        ggplot(aes(x=time,y=value,color=variable))+
        geom_line(size=2) + 
        ggtitle(label = "Coronavirus Curve" ,subtitle = paste0(transm_lab,", ", recov_lab)) +
        labs(x='Time since first infection',y='Proportion of Population')
      


      
      
    })
    
  }
  
)


#### Run the App ####
shinyApp(ui,server)