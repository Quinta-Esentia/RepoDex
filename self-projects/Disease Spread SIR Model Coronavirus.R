#~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# SIR Model for Coronavirus #
# by    Dexter Camison      # 
#         1/04/2020         #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Source
# https://kinglab.eeb.lsa.umich.edu/480/nls/de.html
# also
# https://www.youtube.com/watch?v=k6nLfCbAzgo


# Load require libraries
# If you don't have them, use: install.packages("deSolve")

library(deSolve)
library(tidyverse)

# Estimated transmission rate (R_0) is estimated to be between 1.5 and 3.5: https://www.imperial.ac.uk/mrc-global-infectious-disease-analysis/covid-19/
Transmission_Rate <- 3.2 # Start with maybe 3.2, and gradually drop values down to 0.5 to see interesting behaviour (eg not all people being infected/some of the population stil susceptible)

Recovery_Rate <- 0.23 # Start with maybe 0.23, can play with these values too - this is harder to change in reality, and has less of an effect in flattening the curve

maxT <- 40 # Time to run the simulation

# Create the system of ordinary differential equations
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
