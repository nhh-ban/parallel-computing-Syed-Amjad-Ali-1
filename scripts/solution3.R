
library(doParallel)

maxcores <- 14
Cores <- min(parallel::detectCores(), maxcores)
cl <- makeCluster(Cores)
registerDoParallel(cl)

MParTweedieTests <-
  function(N, M, sig, maxcores) {
    Cores <- min(parallel::detectCores(), maxcores)
    
    cl <- makeCluster(Cores)
    registerDoParallel(cl)
    
    m_per_core <- round(M / Cores)
    m_total <- m_per_core * Cores
    
    rejects_per_core <-
      foreach(
        i = 1:Cores,
        .combine = 'rbind',
        .packages = c('magrittr', 'dplyr', 'tweedie'),
        .export = c('simTweedieTest')
      ) %dopar%
      sum(replicate(m_per_core, simTweedieTest(N)) < sig)
    
    stopCluster(cl)
    
    sum(rejects_per_core) / m_total
  }



#for (i in 1:nrow(df)) {
#  df$share_reject[i] <-
#    MParTweedieTests(
#      df$N[i],
#      df$M[i],
#      df$type[i],
#      .05)
#}

for (i in 1:nrow(df)) {
  df$share_reject[i] <-
    MParTweedieTests(
      df$N[i],
      df$M[i],
      0.05,  
      maxcores  
    )
}



stopCluster(cl)
