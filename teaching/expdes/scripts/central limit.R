
# first lets create a true population that we will be studying
fish <- rexp(1000000, rate=.5)

# calculate the true mean
t.mean <- mean(fish)

# look at the true population
hist(fish, xlim=c(0,15))

# take one sample of fish
samp <- sample(x=fish, size=100)

# create a vector for our samples and for our eval
# of whether or not we get a significant result
samps <- c()
check <- c()

# this will repeat our experiment 1000 times
for(i in 1:1000){
  # here we collect a sample of fish
  x <- sample(x=fish, size=200)
  # we are using the t.test function as a way to get
  # confidence intervals rather than calculating them ourselves
  z <- t.test(x)
  # here we ask whether the true mean in in the 95% confidence interval
  check[i] <- z$conf.int[1] < t.mean & z$conf.int[2] > t.mean
  # here we just store the mean that we get from each sample
  # we do this so we can see that the distributions of means is 
  # indeed normal
  samps[i] <- mean(x)
}

# check is T/F vector so we can sum the true values and
# divide by our number of replicates
sum(check)/1000
# here we can look at the distribution of means
hist(samps)


