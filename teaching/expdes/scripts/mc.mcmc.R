# monte carlo
# heath blackmon
# read in some data
dat <- read.csv("retrogene.csv")

# get proportions to use as probabilities
prop.gene <- dat[1, 2:11]/dat[1, 12]
prop.size <- dat[2, 2:11]/dat[2, 12]
# initial variables to hold results
par.count <- c()
ret.count <- c()
# perform the monte carlo
for(i in 1:100000){
  par.count[i] <- sum(sample(1:10, 142, replace=T, prob = prop.gene) == 2)
  ret.count[i] <- sum(sample(1:10, 142, replace=T, prob = prop.size) == 2)
}
plot(density(par.count, bw=.5), 
     xlab="parent count", main="",
     xlim=c(9,46))
abline(v=45, col="red")
sum(par.count >= 45)/100000

plot(density(ret.count, bw=.5), 
     xlab="retrogene count", main="",
     xlim=c(9,46))
abline(v=40, col="red")
sum(ret.count >= 40)/100000



mcmc1 <- read.csv("mcmc.log.file.csv")
mcmc2 <- read.csv("mcmc.logfile2.csv")

post <- mcmc1[501:1000,]
plot(y=post$asc1, 
     x=rnorm(mean=1, n=500, sd=.1),
     xlim=c(.5,2.5), pch=16, cex=.25)
points(y=post$desc1,x=rnorm(mean=2, n=500, 
                            sd=.1),
       pch=16, cex=.25)


plot(mcmc1$p, type="l")
plot(mcmc2$p, type="l")

