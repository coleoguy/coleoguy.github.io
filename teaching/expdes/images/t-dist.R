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


fisher.test(x)


library(DescTools)
GTest(x)


x <- matrix(c(140,80,76,20,4,13,89,3),4,2)
chisq.test(x)


x <- c(1.2, -.2, .4, -.5)
names(x) <- c("A","X","Y","AA")
z <- barplot(x, ylim=c(-1,2.0))
se <- c(.2,.05,.4,.1)
for(i in 1:4){
  lines(x=c(z[i],z[i]),y=c(x[i]+se[i],x[i]-se[i]), lwd=2)
  lines(x=c(z[i]-.1,z[i]+.1),y=c(x[i]+se[i],x[i]+se[i]), lwd=2)
  lines(x=c(z[i]-.1,z[i]+.1),y=c(x[i]-se[i],x[i]-se[i]), lwd=2)
}


x <- c(1.2, .35)
names(x) <- c("treatment","control")
z <- barplot(x, ylim=c(-.5,2.0))
se <- c(.4, .4)
for(i in 1:2){
  lines(x=c(z[i],z[i]),y=c(x[i]+se[i],x[i]-se[i]), lwd=2)
  lines(x=c(z[i]-.1,z[i]+.1),y=c(x[i]+se[i],x[i]+se[i]), lwd=2)
  lines(x=c(z[i]-.1,z[i]+.1),y=c(x[i]-se[i],x[i]-se[i]), lwd=2)
}

x <- cbind(rnorm(20,mean=10),rnorm(20,mean=12,sd=2),rnorm(20,mean=14),rnorm(20,mean=16))
x2 <- cbind(rnorm(20,mean=10),rnorm(20,mean=12),rnorm(20,mean=13),rnorm(20,mean=9))
pErr <- function(x, y, w, ci=.95){
  # x is position on x axis
  # y is vector of y measures
  # w is whisker size
  # ci = confidence interval
  ybar <- mean(y)
  se <- sd(y) / sqrt(length(y))
  q <- 1-(1-ci)/2
  err <- qnorm(q) * se
  lines(x=c(x,x), y=c(ybar+err, ybar-err))
  lines(x=c(x-w,x+w), y=c(ybar+err, ybar+err))
  lines(x=c(x-w,x+w), y=c(ybar-err, ybar-err))
}

par(mfcol=c(1,2))

plot(0,0,col="white",xlim=c(0,2.5),ylim=c(8,17),xlab="", ylab="",xaxt="n")
spots<- c(.5, 2, .5, 2)
cols <- c("red","red","darkgreen","darkgreen")
for(i in 1:4){
  pErr(x=spots[i], y=x[, i], w=.05, ci=.95)
  points(y=mean(x[, i]), x=spots[i], pch=16, cex=1.5, col=cols[i])
}
lines(x = c(.5, 2), y = c(mean(x[, 1]), mean(x[, 2])), lty = 3)
lines(x = c(.5, 2), y = c(mean(x[, 3]), mean(x[, 4])), lty = 3)
axis(side = 1, at = c(.5, 2), labels = c("Env 1", "Env 2"))
text(x = c(2, 2), y = c(mean(x[, 2]), mean(x[, 4])), c("Strain 1","Strain 2"), pos=4,cex=.7)

plot(0,0,col="white",xlim=c(0,2.5),ylim=c(8,14),xlab="", ylab="",xaxt="n")
spots<- c(.5, 2, .5, 2)
cols <- c("red","red","darkgreen","darkgreen")
for(i in 1:4){
  pErr(x=spots[i], y=x2[, i], w=.05, ci=.95)
  points(y=mean(x2[, i]), x=spots[i], pch=16, cex=1.5, col=cols[i])
}
lines(x = c(.5, 2), y = c(mean(x2[, 1]), mean(x2[, 2])), lty = 3)
lines(x = c(.5, 2), y = c(mean(x2[, 3]), mean(x2[, 4])), lty = 3)
axis(side = 1, at = c(.5, 2), labels = c("Env 1", "Env 2"))
text(x = c(2, 2), y = c(mean(x2[, 2]), mean(x2[, 4])), c("Strain 1","Strain 2"), pos=4,cex=.7)


power.t.test(delta=25,sd=50, power=.80)


y <- c(rnorm(10, mean = 4.2, sd = 0.25),
       rnorm(10, mean = 4.8, sd = 0.5),
       rnorm(10, mean = 5.1, sd = 0.25))
cols <- c(rep("blue",10),rep("red",10),rep("darkgreen",10))
par(mfcol=c(1,3))

plot(y,col=cols,pch=16, main="total variance", xlab="",xaxt="n")
lines(x=c(1,30),y=c(mean(y[1:30]),mean(y[1:30])))
for(i in 1:30) lines(x=c(i,i), y=c(y[i], mean(y[1:30])), col="gray")

plot(y,col=cols,pch=16, main="between group variance", xlab="",xaxt="n")
lines(x=c(1,30),y=c(mean(y[1:30]),mean(y[1:30])))
lines(x=c(1,10),y=c(mean(y[1:10]),mean(y[1:10])), col="gray")
lines(x=c(11,20),y=c(mean(y[11:20]),mean(y[11:20])), col="gray")
lines(x=c(21,30),y=c(mean(y[21:30]),mean(y[21:30])), col="gray")
for(i in 1:10) lines(x=c(i,i), y=c(mean(y[1:30]), mean(y[1:10])), col="gray")
for(i in 11:20) lines(x=c(i,i), y=c(mean(y[1:30]), mean(y[11:20])), col="gray")
for(i in 21:30) lines(x=c(i,i), y=c(mean(y[1:30]), mean(y[21:30])), col="gray")

plot(y,col=cols,pch=16, main="within group variance", xlab="",xaxt="n")
lines(x=c(1,10),y=c(mean(y[1:10]),mean(y[1:10])))
for(i in 1:10) lines(x=c(i,i), y=c(y[i], mean(y[1:10])), col="gray")
lines(x=c(11,20),y=c(mean(y[11:20]),mean(y[11:20])))
for(i in 11:20) lines(x=c(i,i), y=c(y[i], mean(y[11:20])), col="gray")
lines(x=c(21,30),y=c(mean(y[21:30]),mean(y[21:30])))
for(i in 21:30) lines(x=c(i,i), y=c(y[i], mean(y[21:30])), col="gray")



data("chickwts")
tapply(chickwts$weight, chickwts$feed, mean)
feed.types <- lm(weight~feed, data=chickwts)
anova(feed.types)
aov(feed.types)


install.packages("multcomp", dependencies=TRUE)
library(multcomp)
feed.lm <- lm(weight ~ feed, data=chickwts)
feed.anova <- anova(feed.types)
feed.aov <- aov(feed.types)
TukeyHSD(feed.aov)

tapply(chickwts$weight, chickwts$feed, mean)

#sets the order of the treatments
chickwts$feed <- factor(chickwts$feed, 
                        levels=c("sunflower", "casein",
                                 "meatmeal","soybean",
                                 "linseed", "horsebean")) 
stripchart(weight ~ feed, data=chickwts, 
           method = "jitter", vertical = TRUE, cex.axis =.7,
           col = "gray", pch = 1, cex = .5, las = 3)
#Add error bars:
#First calculate means and SDs
meanShift <- tapply(chickwts$weight, chickwts$feed, mean)
sdevShift <- tapply(chickwts$weight, chickwts$feed, sd)
n <- tapply(chickwts$weight, chickwts$feed, length)
feed_table <- data.frame(mean = meanShift, 
                         std.dev = sdevShift, n = n)
#Now add the SEM for each group:
seShift <- 1.96 * sdevShift / sqrt(n)
segments(1:6, meanShift - seShift, 
         1:6, meanShift + seShift)
points(meanShift ~ c(1:6), pch = 16)

