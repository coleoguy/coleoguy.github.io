
# Permutation Test
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


# You're lab has an old nanodrop that you aren't sure is working
# However, you have 100s of extractions that need to be quantified
# You decide to test your nanodrop against one in another lab that
# is brand new. You picked 10 samples that you will quantify on both
# machines. 
old <- c(1.87, 1.91, 1.86, 1.81, 1.87, 
         1.72, 1.75, 1.69, 1.74, 1.61)
new <- c(1.74, 1.62, 1.73, 1.75, 1.88, 
         1.72, 1.86, 1.80, 1.77, 1.84)

# From years of observation you know that typically only 
# 63% of males and 74% of female hedgehogs survive to one
# year of age. You tagged 50 females and 50 males last year and
# during your repeat survey you document 38 females and 
# 24 males alive. Assume that all hedgehogs not documented 
# as still alive are dead. Do the survival rates in your study
# agree with long term trends?


# You studying acyl sugar productions in tomato. You have 
# measured 


