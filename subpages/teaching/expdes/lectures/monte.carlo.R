# example monte carlo

# create an object to hold our observed data in
dat <- as.data.frame(matrix(NA, 24, 5))
colnames(dat) <- paste("plot", 1:5)

# simulate observed data
dat$`plot 1` <- rbinom(24, 1, prob = .1)
dat$`plot 3` <- rbinom(24, 1, prob = .1)
dat$`plot 5` <- rbinom(24, 1, prob = .1)
dat$`plot 2` <- rbinom(24, 1, prob = .3)
dat$`plot 4` <- rbinom(24, 1, prob = .3)

# create a summary that can represent our observations
emp.obs <- colSums(dat)

# create an object to hold our Monte Carlo results
res <- matrix(NA, 1000, 5)

# caluclate the typical probability of occurence
# across the empirical data
prob <- sum(dat)/120

# perform the simulation 1000 times
for(i in 1:1000){
  res[i,] <- colSums(matrix(rbinom(120, 1, prob=prob), 24, 5))
}

# calculate the p-value for the occurence frequency
sum(res[,1] >= emp.obs[1])/1000
sum(res[,2] >= emp.obs[2])/1000
sum(res[,3] >= emp.obs[3])/1000
sum(res[,4] >= emp.obs[4])/1000
sum(res[,5] >= emp.obs[5])/1000

