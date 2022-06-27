

sample_from_pop <- function(distType, N_pop, n_samp, size_samp) {
  # distType = Type of distribution: from c("Normal", "Exponential", "Chisquared", "Uniform")
  # N_pop = Size of the population
  # n_samp = number of samples to take from the population
  # size_samp = size of the samples to take from the population
  
  ### Conditional Options for Different Distributions
  if(distType == "Gaussian"){
    df <- data.frame(
      x = rnorm(N_pop, mean = 10, sd = 3)
    )
  }
  
  if(distType == "Exponential"){
    df <- data.frame(
      x = rexp(N_pop, rate = 0.5)
    )
  }
  
  if(distType == "Chi Squared"){
    df <- data.frame(
      x = rchisq(N_pop, df = 3)
    )
  }
  
  if(distType == "Uniform"){
    df <- data.frame(
      x = runif(N_pop, min = 0, max = 10)
    )
  }
  
  
  
  # df <- data.frame(
    # x = rnorm(N_pop, mean = 100, sd = 15)
    # x = rexp(N_pop, rate = 3)
    # x = rchisq(N_pop, df = 1)
    # x = runif(N_pop, min = 0, max = 100)
  # )
  
  # # Population Hist
  # g1 <- ggplot(df) +
  #   geom_histogram(aes(x), bins = 50, 
  #                  fill = 'white', colour = 'black') +
  #   labs(title = "Histogram of Population",
  #        subtitle = paste0("Population Size = ",N_pop))# +
  # # coord_cartesian(xlim=c(50,150))
  # print(g1)
  
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
