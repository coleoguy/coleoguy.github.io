# Example of elevated false positives when we "peak"
# at our data.

# first we create a vector that is our whole population
pop <- c(rep("fem", 600), rep("mal", 400))

# now we sample 100 indiv. from a population 1000 times and
# each time we count the number of males in our sample
samp <- c()
for(i in 1:1000){
  samp[i] <- sum(sample(pop, 100) == "mal")
}

# lets take a look at the distribution of the number
# of males that we got in each sample
hist(samp)

# lets create two vectors of pvalues one where we don't
# peak and just look at whether are sample is significantly
# different from our expectations and another where we first
# peak at see if it looks high or low and then test if it is
# higher or lower than we expect
std.pvalues <- c()
peaked.pvalues <- c()
for(i in 1:1000){
  std.pvalues[i] <- binom.test(samp[i], 100, .4)$p.value
  if(samp[i]>40){
    peaked.pvalues[i] <- binom.test(samp[i], 100, .4, alternative = "g")$p.value
  }
  if(samp[i]<40){
    peaked.pvalues[i] <- binom.test(samp[i], 100, .4, alternative = "l")$p.value
  }
}

# here is the number of positives when we do the standard test
# we expect to see less than 50 (5%)
sum(std.pvalues<=.05)

# here we see more than 5% false positives
sum(peaked.pvalues<=.05, na.rm=T)

# here just illustrtating that binomial test is a special case
# of the chi-square test
binom.test(34,90, .5)
chisq.test(matrix(c(34,56)))


# lets look at generating the t-statistic ourselves
# here is the formula for the t statistic
(mean - hyp) / (sd/sqrt(n))

mu <- 1
pop <- rnorm(10000, mean=mu, sd=0.7)
tstat <- c()
for(i in 1:10000){
  samp <- sample(pop, 20)
  # this is the step where we record the t statistic
  # remember we simulated this data with the null so this
  # is what we expect to see from the t statitic when nothing
  # interesting is happening.
  tstat[i] <- (mean(samp) - mu) / (sd(samp)/sqrt(length(samp)))
}

# and here we show that we are able to generate just what we expect.
plot(density(tstat))


