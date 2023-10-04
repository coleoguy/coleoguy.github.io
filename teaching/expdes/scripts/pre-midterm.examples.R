
# Permutation Test Example One
set.seed(1)
cave <- rpois(n = 20, lambda = 24)
surf <- rpois(n = 20, lambda = 22)
obs.dif <- mean(cave) - mean(surf)
null.dist <- c()
for(i in 1:100000){
  x <- sample(c(cave, surf))
  null.dist[i] <- mean(x[1:20]) - mean(x[21:40])
}
plot(density(abs(null.dist)))
abline(v=obs.dif)
sum(abs(null.dist) >= obs.dif) / length(null.dist)

# Permutation Test Example Two
set.seed(5)
crick1 <- rpois(15, lambda = 12)
crick3 <- rpois(15, lambda = 10)
obs.dif <- mean(crick1) - mean(crick3)
null.dist <- c()
for(i in 1:100000){
  x <- sample(c(crick1, crick3))
  null.dist[i] <- mean(x[1:15]) - mean(x[16:30])
}
plot(density(abs(null.dist)))
abline(v=abs(obs.dif))
sum(abs(null.dist) >= abs(obs.dif)) / length(null.dist)

# Binomial Test
# Chi-Square
# T-tests
# Levine's
# Sign Test
# Mann-Whitney


# Your lab has an old nanodrop that you aren't sure is working
# However, you have 100s of extractions that need to be quantified
# You decide to test your nanodrop against one in another lab that
# is brand new. You picked 10 samples that you will quantify on both
# machines. 
old <- c(1.87, 1.91, 1.86, 1.81, 1.87, 
         1.72, 1.75, 1.69, 1.74, 1.61)
new <- c(1.74, 1.62, 1.73, 1.75, 1.88, 
         1.72, 1.86, 1.80, 1.77, 1.84)

t.test(old, new, paired=T)


# From years of observation you know that typically only 
# 63% of males and 74% of female hedgehogs survive to one
# year of age. You tagged 50 females and 50 males last year and
# during your repeat survey you document 38 females and 
# 24 males alive. Assume that all hedgehogs not documented 
# as still alive are dead. Do the survival rates in your study
# agree with long term trends?
null <- rbinom(1000, 50, .63)
plot(density(null))
abline(v=24)
sum(null <= 24)/1000

binom.test(24, 50, .63)
binom.test(38, 50, .74)
# You are studying water purification failure. A town's 
# water supply was contaminated leading to kidney problems
# in some residents. You are interested in determining 
# wether sexes are impacted differently. You found that
# 1200 residents drank the contaminated water 632 were women
# 568 were men. 57 men got ill while 95 women got sick.
# Does sex have an impact on whether people get sick?
95/632
57/568
x <- matrix(c(537, 511, 95, 57), 2, 2)
colnames(x) <- c("healthy", "ill")
row.names(x) <- c("female", "male")
chisq.test(x)

# Testing the effect of window angle on bird impact deaths. 
# Treatments were vertical, 20, or 40 degrees off vertical. 
# During the experiment 30, 15, and 8 birds
# were killed by each type of window respectively

