plot(density(rnorm(100)),lwd=4,col="red")
lines(density(rnorm(100,mean=.5)),col="blue",lwd=4)

x <- seq(from=-5, to=5, length.out = 1000)
plot(y=dnorm(x),x=x, type="l", col="red", lwd=2)
df <- 20
lines(y=dt(x, df),x=x, type="l", col="#084594", lwd=2)
df <- 8
lines(y=dt(x, df),x=x, type="l", col="#4292c6", lwd=2)
df <- 2
lines(y=dt(x, df),x=x, type="l", col="#9ecae1", lwd=2)
df <- 1
lines(y=dt(x, df),x=x, type="l", col="#c6dbef", lwd=2)
yspot <- seq(from=.4, to=.325,length.out=5)
spot.col <- c("red", "#084594", "#4292c6",
              "#9ecae1", "#c6dbef")
points(x = rep(2.5,5), y = yspot, col = spot.col, pch = 15)
text(x = rep(2.5,5), y = yspot, c("normal", "n=21", 
                             "n=9", "n=2", "n=1"),
     pos = 4, cex = .7)



x <- seq(from=-5, to=5, length.out = 1000)
y <- dt(x, df=20)
plot(x = x, y = y)

# these are our observed time
# spent in dark region
x <- c(.45, .43, .31, 
       .54, .47, .39)

t.test(x, mu=.5)


dev <- mean(x)-.5
SEM <- sd(x)/sqrt(length(x))
dev/SEM



# population 1 measures
x <- c(.45, .43, .31, .37, 
       .47, .25, .39, .22)

# population 2 mesures 
y <- c(.42, .49, .45, .49,
       .59, .37, .57, .53)

t.test(x, y)


# paired test

# first measure
x <- c(.24, .16, .14, .33, .04)
# second measure
y <- c(.52, .41, .10, .47, .39)

t.test(x, y, paired = T)


# levines
x <- round(rnorm(100, mean=4, sd=1))
y <- round(rnorm(100, mean=4.3, sd=2))
y[y<0] <- 0
par(mfcol=c(1,2))
hist(x, main="females", xlab="number of offspring", col="gray")
hist(y, main="males", xlab="number of offspring", col="gray")
lines(density(x))


quantile(rnorm(200),probs = seq(0.01,0.99,0.01))
x <- c(rnorm(50),rnorm(100,mean=0,sd=.1))
y <- c(rnorm(50),rnorm(50,mean=3,sd=.4),rnorm(50,mean=-3,sd=.4))
qqnorm(x)
qqnorm(y)
#

qqnorm(runif(min=0, max=50, n=5000)) 
set.seed(14)
hist(rnorm(50), col= "gray")
set.seed(6)
hist(rnorm(50), col= "gray")
set.seed(6)
hist(rgamma(50, shape=1), col= "gray")
set.seed(6)
hist(c(rnorm(30,mean=1,sd=.5),rnorm(30,mean=5,sd=.5)), col= "gray")

results<-vector()
for(i in 1:1000){
  x <- rnorm(1000)
  x <- c(x, rnorm(10, mean=1))
  results[i] <- shapiro.test(x)$p.value
}
sum(results<.05)

shapiro.test(x)


log(x)
# if zeros are present
log(x + 1)

asin(sqrt(x))

sqrt(x + .5)
x<- rnorm(100)
y<- rnorm(100)

summary(lm(x~y))

set.seed(8)
x <- rnorm(20, mean=1)
y <- rnorm(20, mean=1.25)
t.test(x, y)
# p-value = 0.07604

wilcox.test(x, y)

binom.test(x=4, n=14, p=.5)

# p-value = 0.1081



crickets <- read.csv("crickets.csv")
obs.vals <- tapply(X = crickets$timeToMating, 
                   INDEX = crickets$feedingStatus, 
                   FUN = mean)
obs.d <- obs.vals[2]-obs.vals[1]
perm <- 10000
perm.d <- vector()
for(i in 1:perm){
  newX <- sample(crickets$timeToMating, replace = F)
  perm.vals <- tapply(X = newX, 
                      INDEX = crickets$feedingStatus, 
                      FUN = mean)
  perm.d[i] <- perm.vals[2] - perm.vals[1]
}
plot(density(perm.d))
abline(v = obs.d, col = "red")
sum(perm.d < obs.d) / perm * 2

t.test(crickets$timeToMating~crickets$feedingStatus)
