library(tidyverse)

set.seed(666)
N_pop <- 5000
n_samp <- 100
size_samp <- 1

sample_from_pop <- function(N_pop,n_samp,size_samp) {
  df <- data.frame(
    # x = rnorm(N_pop, mean = 100, sd = 15)
    # x = rexp(N_pop, rate = 3)
    x = rchisq(N_pop, df = 1)
    # x = runif(N_pop, min = 0, max = 100)
  )
  
  # Population Hist
  g1 <- ggplot(df) +
    geom_histogram(aes(x), bins = 50, 
                   fill = 'white', colour = 'black') +
    labs(title = "Histogram of Population",
         subtitle = paste0("Population Size = ",N_pop))# +
   # coord_cartesian(xlim=c(50,150))
  print(g1)
  
  # 1. Sample from population with size size_samp
  # 2. Calculate mean of size_samp
  # 3. Repeat 1 & 2 n_samp number of times
  
  samp_dist <- data.frame(
    x = rep(0, n_samp)
  )
  # samp_dist <- rep(0, n_samp)
  sample_nth <- rep(0, size_samp)
  
  for (i in 1:n_samp) {
    
    sample_nth <- sample(df$x, size = size_samp)
    samp_dist$x[i] <- mean(sample_nth)
    
  }
  
  # Standard Deviation of the Sampling Distribution
  # Standard Error = s/sqrt(n) = sd(df$x)/sqrt(size_samp)
  standard_error <- sd(samp_dist$x) %>% round(digits = 2)
  
  
  g2<- ggplot(samp_dist) + 
    geom_histogram(aes(x), bins = 50, 
                   fill = 'white', colour = 'black') +
    labs(title = "Histogram of the Sampling Distribution of the Mean",
         subtitle = paste0("Number of Samples = ",n_samp,
                           "\nNumber of Observations per Sample = ",size_samp),
         caption = paste0("Standard Error = ", standard_error))# +
    #coord_cartesian(xlim=c(50,150))
  print(g2)
  
}

sample_from_pop(N_pop, n_samp, size_samp)

sample_from_pop(5000,1000,1)
sample_from_pop(5000,1000,10)
sample_from_pop(5000,1000,30)
sample_from_pop(5000,1000,100)
sample_from_pop(5000,1000,1000)
