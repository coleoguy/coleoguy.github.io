# Heath Blackmon
# Review examples in class

data(iris)

# Permutation Test
pl <- iris$Sepal.Width[iris$Species %in% c("versicolor","virginica")]
sp <- iris$Species[iris$Species %in% c("versicolor","virginica")]

# emp obs
empdif <- mean(pl[sp=="versicolor"]) - mean(pl[sp=="virginica"])
# generate a null to compare to
null.dist <- c()
for(i in 1:100000){
  tempsp <- sample(sp)
  null.dist[i] <- mean(pl[tempsp=="versicolor"]) - mean(pl[tempsp=="virginica"])
}
plot(density(abs(null.dist)))
abline(v=abs(empdif), col="red")
pval <- sum(abs(null.dist) >= abs(empdif))/100000

# Chi-square example

dat <- matrix(c(994, 6, 968, 32), 2, 2)
colnames(dat) <- c("V","P")
rownames(dat) <- c("ND","D")
chisq.test(dat, simulate.p.value = F)
chisq.test(dat, simulate.p.value = T, B=1000000)

# Two sample T-test
msc <- c(126,164,148,120,178,183)
gym <- c(151,109,151,174,118,136)
t.test(msc,gym, alternative="l")

# Wilcox Test
soil1 <- c(23,12,45,23,21,45,21)
soil2 <- c(35,45,21,34,67,23,16)
wilcox.test(soil1, soil2)

# permutation test again
repro <- c(10,16,9,8,0,9,9,9,8,3,17,14,17,8,9,18,8,7,7,8)
sex <- c("f","m","f","f", "m",rep("f",3),rep("m",5),"f","m","m","f","m","f","f")

emp.val <- abs(var(repro[sex=="f"]) - var(repro[sex=="m"]))
null.dist <- c()
for(i in 1:10000){
  trepro <- sample(repro)
  null.dist[i] <- abs(var(trepro[sex=="f"]) - var(trepro[sex=="m"]))
  
}

plot(density(null.dist))
hist(null.dist)
emp.pval <- sum(null.dist>=emp.val)/10000

# binomial test

binom.test(x=6,n=7)
binom.test(x=1,n=7)
binom.test(x=345, 647)
binom.test(x=127, 221)
