library(tictoc)




tic("Single CPU on all calculations")
source("scripts/solution1.R")
toc(log = TRUE)



tic("Parallel loop alt 1")
source("scripts/solution2.R")
toc(log = TRUE)

tic("Parallel loop alt 2")
source("scripts/solution3.R")
toc(log = TRUE)



#The second method appears to be the fastest