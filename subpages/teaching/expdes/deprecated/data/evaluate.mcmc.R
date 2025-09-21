dat <- read.csv("mcmc.log1.csv")
plot(dat$likelihood,
     type="l",
     ylim=c(-5000,max(dat$likelihood)))
dat <- read.csv("mcmc.log2.csv")
plot(dat$p,
     type="l")
