

library(doParallel)

maxcores <- 14
Cores <- min(parallel::detectCores(), maxcores)
cl <- makeCluster(Cores)
registerDoParallel(cl)

res <-
  foreach(
    i = 1:nrow(df),
    .combine = 'rbind',
    .packages = c('magrittr', 'dplyr', 'tweedie')
  ) %dopar%
  tibble(
    N = df$N[i],
    M = df$M[i],
    share_reject =
      MTests(df$N[i],
             df$M[i],
             df$type[i],
             .05)
  )


stopCluster(cl)
