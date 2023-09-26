
# first lets look at what we expect the outcome
# of a binomial process to look like
res <- rbinom(10000, 100, .5)
hist(res, xlim=c(0,100), breaks=30)

# now lets create some data that would be appropriate for 
# a chi square test
dat <- matrix(NA, 2, 2)
colnames(dat) <- c("presence", "absence")
row.names(dat) <- c("SD", "SM")

# instead of picking a single sample size
# and typing it in every where manually
# what I do here is set up a variable nsp
# that will include my sample size and then
# split those species 70% in sexually dimorphic
# and 30% in sexually monomorphic.
nsp <- 600
sd <- nsp * .7
sm <- nsp - sd

# now lets use those numbers to fill out our 
# data table
dat[1,] <- c(sd*.7, sd*.3)
dat[2,] <- c(sm*.6, sm*.4)

# and here we run the test
chisq.test(dat)


# lets see what sample size we need to reach
# to detect a unfair coin that is very close to fair
heads <- c()
pvals <- c()
# lets try to run our test with a sample size that
# varies from 1 to 100000
for(i in 1:100000){
  # this print statement will let us monitor the progress of our code
  print(i)
  # here we use rbinom to do the coin flipping and we store the number of heads
  heads[i] <- rbinom(1, i, prob=.51)
  # here we performt he binomial test
  res <- binom.test(heads[i], n=i, p=.5)
  # here we record the pvalue
  pvals[i] <- res$p.value
}
# since p-values get really tiny and it is hard to tell the difference
# 0, 0.01, 0.05, and 0.10 on a scale that ranges from zero to one
# we will take the negative log of our values to make visualization 
# easier. You have seen this before (every manhatan plot ever)
plot(y=-1*log(pvals), x=1:100000,
     cex=.1, 
     col=rgb(1,0,0,.5),
     pch=16)

# lets add a line at the point of significance
abline(h=-1*log(0.05))



