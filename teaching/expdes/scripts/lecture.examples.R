# heath blackmon
# coleoguy@gmail.com
# this file includes lots of example plots made for 
# experimental design

# make a couple of density plots for a favicon
plot(density(rnorm(100)),lwd=4,col="red")
lines(density(rnorm(100,mean=.5)),col="blue",lwd=4)

# illustrate the difference in the normal
# distribution and the t distribution with sample sizes
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


# illustrates a one sample t-test
# these are our observed time
# spent in dark region
x <- c(.45, .43, .31, 
       .54, .47, .39)
t.test(x, mu=.5)

# the math under the hood for the t.test
dev <- mean(x)-.5
SEM <- sd(x)/sqrt(length(x))
dev/SEM


# example for two-sample ttest
# population 1 measures
x <- c(.45, .43, .31, .37, 
       .47, .25, .39, .22)

# population 2 mesures 
y <- c(.42, .49, .45, .49,
       .59, .37, .57, .53)

t.test(x, y)


# example for paired test
# first measure
x <- c(.24, .16, .14, .33, .04)
# second measure
y <- c(.52, .41, .10, .47, .39)
t.test(x, y, paired = T)


# levines test example
par(mfcol=c(1,2))
set.seed(10)
x <- round(rnorm(100, mean=4, sd=1.2))
y <- round(rnorm(100, mean=4.3, sd=2))
y[y<0] <- 0
hist(x, main="females", xlab="number of offspring", col="gray")
hist(y, main="males", xlab="number of offspring", col="gray")

library(car)
data("InsectSprays")
leveneTest(y=InsectSprays$count, 
           group=InsectSprays$spray,
           cetner="median")

stripchart(count ~ spray, data=InsectSprays, 
           method = "jitter", vertical = FALSE, cex.axis =.7,
           col = "gray", pch = 16, cex = .45, las = 3)
meds <- tapply(InsectSprays$count, InsectSprays$spray, median)
for(i in 1:6) points(x=meds[i],y=i,pch="l")

# looking at normality
quantile(rnorm(200),probs = seq(0.01,0.99,0.01))
x <- c(rnorm(50),rnorm(100,mean=0,sd=.1))
y <- c(rnorm(50),rnorm(50,mean=3,sd=.4),rnorm(50,mean=-3,sd=.4))
qqnorm(x)
qqnorm(y)
qqnorm(runif(min=0, max=50, n=5000)) 
set.seed(14)
hist(rnorm(50), col= "gray")
set.seed(6)
hist(rnorm(50), col= "gray")
set.seed(6)
hist(rgamma(50, shape=1), col= "gray")
set.seed(6)
hist(c(rnorm(30,mean=1,sd=.5),rnorm(30,mean=5,sd=.5)), col= "gray")

# shapiro.test
results<-vector()
for(i in 1:1000){
  x <- rnorm(1000)
  x <- c(x, rnorm(10, mean=1))
  results[i] <- shapiro.test(x)$p.value
}
sum(results<.05)

shapiro.test(x)

# transformations
log(x)
# if zeros are present
log(x + 1)

asin(sqrt(x))

sqrt(x + .5)
x<- rnorm(100)
y<- rnorm(100)

summary(lm(x~y))


# non-parametric tests
set.seed(8)
x <- rnorm(20, mean=1)
y <- rnorm(20, mean=1.25)
t.test(x, y)
# p-value = 0.07604

wilcox.test(x, y)

binom.test(x=4, n=14, p=.5)

# p-value = 0.1081


# permutation tests
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

# fishers exact test
fisher.test(x)

# GTest
library(DescTools)
GTest(x)


x <- matrix(c(140,80,76,20,4,13,89,3),4,2)
chisq.test(x)

# misconceptions about confidence intervals
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

# statistical interaction

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



# testing for power
power.t.test(delta=25,sd=50, power=.80)

# illustrating types of variance
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


# illustrating basic anova
data("chickwts")
tapply(chickwts$weight, chickwts$feed, mean)
feed.types <- lm(weight~feed, data=chickwts)
anova(feed.types)
aov(feed.types)

# illustrating basic anova nothing happening
z <- chickwts
z$weight <- sample(z$weight)
feed.types <- lm(weight~feed, data=z)
anova(feed.types)
x <- seq(from=0, to=5,length.out=200)
y <- df(x, df1=5,df2=65)
plot(y~x,type="l",xlab="F-statistic")
abline(h=0)
abline(v=1.2792, col="red")
# plotting variances for nothing happening ANOVA
# illustrating types of variance
1:10, 11:22, 23:36, 37:48, 49:59, 60:71
cols <- c(rep("#e41a1c", 10), rep("#377eb8", 12), rep("#4daf4a", 14),
          rep("#984ea3", 12), rep("#ff7f00", 11), rep("#a65628", 12))
par(mfcol=c(1,2))

plot(y=z$weight,x=1:71,col=cols,pch=16, cex=.5,cex.main=.75,
     main="between group variance", xlab="",xaxt="n")
lines(x=c(1,71),y=c(mean(z$weight[1:71]),mean(z$weight[1:71])))
lines(x=c(1,10),y=c(mean(z$weight[1:10]),mean(z$weight[1:10])), col="gray")
lines(x=c(11,22),y=c(mean(z$weight[11:22]),mean(z$weight[11:22])), col="gray")
lines(x=c(23,36),y=c(mean(z$weight[23:36]),mean(z$weight[23:36])), col="gray")
lines(x=c(37,48),y=c(mean(z$weight[37:48]),mean(z$weight[37:48])), col="gray")
lines(x=c(49,59),y=c(mean(z$weight[49:59]),mean(z$weight[49:59])), col="gray")
lines(x=c(60,71),y=c(mean(z$weight[60:71]),mean(z$weight[60:71])), col="gray")

for(i in 1:10) lines(x=c(i,i), col="gray",lwd=.5,
                     y=c(mean(z$weight[1:71]), mean(z$weight[1:10])))
for(i in 11:22) lines(x=c(i,i), col="gray",lwd=.5,
                     y=c(mean(z$weight[1:71]), mean(z$weight[11:22])))
for(i in 23:36) lines(x=c(i,i), col="gray",lwd=.5,
                     y=c(mean(z$weight[1:71]), mean(z$weight[23:36])))
for(i in 37:48) lines(x=c(i,i), col="gray",lwd=.5,
                     y=c(mean(z$weight[1:71]), mean(z$weight[37:48])))
for(i in 49:59) lines(x=c(i,i), col="gray",lwd=.5,
                     y=c(mean(z$weight[1:71]), mean(z$weight[49:59])))
for(i in 60:71) lines(x=c(i,i), col="gray",lwd=.5,
                     y=c(mean(z$weight[1:71]), mean(z$weight[60:71])))

plot(y=z$weight,x=1:71,col=cols,pch=16, cex=.5,cex.main=.75,
     main="within group variance", xlab="",xaxt="n")
1:10, 11:22, 23:36, 37:48, 49:59, 60:71
lines(x=c(1,10),y=c(mean(z$weight[1:10]),mean(z$weight[1:10])))
lines(x=c(11,22),y=c(mean(z$weight[11:22]),mean(z$weight[11:22])))
lines(x=c(23,36),y=c(mean(z$weight[23:36]),mean(z$weight[23:36])))
lines(x=c(37,48),y=c(mean(z$weight[37:48]),mean(z$weight[37:48])))
lines(x=c(49,59),y=c(mean(z$weight[49:59]),mean(z$weight[49:59])))
lines(x=c(60,71),y=c(mean(z$weight[60:71]),mean(z$weight[60:71])))
for(i in 1:10) lines(x=c(i,i), 
                     y=c(z$weight[i], mean(z$weight[1:10])),
                     col="gray")
for(i in 11:22) lines(x=c(i,i), 
                     y=c(z$weight[i], mean(z$weight[11:22])),
                     col="gray")
for(i in 23:36) lines(x=c(i,i), 
                     y=c(z$weight[i], mean(z$weight[23:36])),
                     col="gray")
for(i in 37:48) lines(x=c(i,i), 
                     y=c(z$weight[i], mean(z$weight[37:48])),
                     col="gray")
for(i in 49:59) lines(x=c(i,i), 
                     y=c(z$weight[i], mean(z$weight[49:59])),
                     col="gray")
for(i in 60:71) lines(x=c(i,i), 
                     y=c(z$weight[i], mean(z$weight[60:71])),
                     col="gray")







# post-hoc tests
feed.lm <- lm(weight ~ feed, data=chickwts)
feed.anova <- anova(feed.lm)
feed.aov <- aov(feed.lm)
TukeyHSD(feed.aov)

tapply(chickwts$weight, chickwts$feed, mean)

#plotting data that you might use anova on
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


# non-parametric alternatives
kruskal.test(weight ~ feed, data = chickwts)
install.packages("dunn.test", dependencies=TRUE)
library(dunn.test)
dunn.test(chickwts$weight, g=chickwts$feed,
          altp = T, method = "bonferroni")

# spurious correlations
temps <- read.csv("temp.csv")[seq(from=1, to=271, by=2),c(2,3)]
hrs <- read.csv("baseball.csv")[2:137,c(1,13)]
plot(hrs$HR ~ temps$Mean,
     xlab="global temp deviation\nfrom 1951-80 mean",
     ylab="average number of\nhomeruns per player",
     cex.lab=.6,
     cex.axis=.6,
     col = rgb(.8, 0, 0, .6),
     pch = 16, cex = .6)
cor.test(x=hrs$HR, y=temps$Mean)
abline(lm(hrs$HR ~ temps$Mean))
text(x=.6,y=.3,"r = 0.76\np < 0.001",pos=4,cex=.65)
summary(lm(hrs$HR ~ temps$Mean))

#central limit theorem
par(mfcol=c(2,1))
pop <- rexp(10000)
hist(pop,main="Individual Body Sizes - Population")
tmean <- mean(pop)
text(x=4,2000,labels=tmean)
means <- vector()
for(i in 1:1000){
  samp <- sample(pop, 50)
  means[i] <- mean(samp)
}
hist(means,main="Mean Body Size - Samples")

# types of correlation
z <- 200
x1 <- rnorm(z)
ystrong.pos <- rnorm(z, mean = x1, sd = .5)
x2 <- rnorm(z)
ystrong.neg <- rnorm(z, mean = -x2, sd = .5)
x3 <- rnorm(z)
yweak <- rnorm(z, mean = x3, sd = 2)
x4 <- rnorm(z)
ynone <- rnorm(z)

par(mfcol=c(2,2))
plot(ynone~x4,pch=16, cex=.75,col=rgb(1,0,0,.5)
     ,xlab="X",ylab="Y",main="no correlation")
plot(yweak~x3,pch=16, cex=.75,col=rgb(1,0,0,.5)
     ,xlab="X",ylab="Y",main="weak positive correlation")
plot(ystrong.pos~x1,pch=16, cex=.75,col=rgb(1,0,0,.5)
     ,xlab="X",ylab="Y",main="strong positive correlation")
plot(ystrong.neg~x2,pch=16, cex=.75,col=rgb(1,0,0,.5)
     ,xlab="X",ylab="Y",main="strong negative correlation")



#examples of fine data
x <- rnorm(250, mean=6)
par(mfcol=c(2,2))
par(mar=c(2,2,2,2))
y <- rnorm(250, mean=x, sd=2)
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)
y <- rnorm(250)
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)
y <- rnorm(250, mean=x, sd=1)
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)
y <- rnorm(250, mean=x, sd=.2)
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)

# examples of data that should scare/excite you
set.seed(1)
x <- rnorm(250, mean=6)
par(mfcol=c(2,2))
par(mar=c(2,2,2,2))
set.seed(2)
y <- rnorm(250, mean=x^3, sd=x^3)
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)
set.seed(2)
y <- rnorm(250, mean=5, sd=abs(x-mean(x)))
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)
set.seed(2)
y <- rnorm(250, mean=x, sd=.2)
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)
set.seed(2)
x <- c(rnorm(125, mean=1.5), rnorm(125, mean=7))
y <- c(rnorm(125, mean=.5), rnorm(125, mean=7))
plot(y~x, cex.axis=.8, col=rgb(1,.1,0,.6),pch=16,cex=.5)

# correlation
x <- rnorm(20, mean=6)
y <- rnorm(20, mean=x, sd=2)
cor.test(x, y, method = "spearman")
cor.test(x, y, method = "pearson")

# f distribution
x <- seq(from=0, to=20, length.out=500)
y <- df(x, df1=5, df2=65)
plot(x=x, y=y, type="l",
     main="",xlab="F-statistic", xlim=c(0,20))
abline(v=15.36, col="red")
help(rf)

# regression

set.seed(3)
x <- runif(min = 1, max = 10, 20)
y <- rnorm(20, mean = x, sd = 2)
plot(y ~ x, col = rgb(1, 0, 0, .6),
     cex = .75, pch = 16,
     xlab = "predictor", ylab = "response")
fit.xy <- lm(y ~ x)
abline(fit.xy, col = rgb(0, 0, 0, .5))


set.seed(3)
x <- runif(min = 1, max = 10, 20)
y <- rnorm(20, mean = x, sd = 2)
fit.xy <- lm(y ~ x)

par(mfcol=c(2,1))
par(mar=c(3,3,.5,.5))
plot(y ~ x, col = rgb(1, 0, 0, .6),
     cex = .75, pch = 16,
     xlab = "predictor", ylab = "response")
lines(x=c(2,9.1),
      y=c(mean(y), mean(y)), 
      col = rgb(0, 0, 0, .5))
for(i in 1:20) lines(x=c(x[i],x[i]),
                     y=c(y[i], mean(y)))

plot(y ~ x, col = rgb(1, 0, 0, .6),
     cex = .75, pch = 16,
     xlab = "predictor", ylab = "response")
abline(fit.xy, col = rgb(0, 0, 0, .5))
z <- y-fit.xy$residuals
for(i in 1:20) lines(x=c(x[i],x[i]),
                     y=c(y[i], z[i]))







for(i in 1:20){
  lines(x = c(x[i],x[i]),
        y = c(y[i],y[i]-fit.xy$residuals[i]),
        , col = rgb(0, .6, 0, .75))
}

set.seed(3)
x <- runif(min = 1, max = 10, 20)
y <- rnorm(20, mean = x, sd = 2)
fit.xy <- lm(y ~ x)
summary(fit.xy)
plot(y~x)


a <- rnorm(100)
b <- rnorm(100)
summary(lm(a~b))


# t distribution
x <- seq(from=0, to=6,length.out=200)
y <- dt(x, df=18)
plot(x=x, y=y, type="l", xlab="t-distribution")
abline(v=5.93, col="red")


# horn size residuals
gnat <- read.csv("../hw-labs/data/gnatocerus.csv")
fit <- lm(horns ~ body, data = gnat)
plot(gnat$horns ~ gnat$body,
     xlab = "body size",
     cex.lab = .7, cex.axis = .7,
     ylab = "horn size",
     main = "Gnatocerus cornutus",
     pch = 16, cex = .6, col = rgb(0, 0, 1, .6))

#Add the regression line
abline(fit, lty=3, col="gray35")

#Add confidence limits for the regression line
xpt <- seq(par("usr")[1], par("usr")[2])
ypt <- data.frame(predict(fit, 
                          newdata = data.frame(body = xpt), 
                          interval = "confidence", 
                          level = 0.95,
                          type = "response"))
lines(ypt$lwr ~ xpt, lwd = .6, lty = 2)
lines(ypt$upr ~ xpt, lwd = .6, lty = 2)

par(mfcol=c(2,2))
par(mar=c(4,4,3,3))
plot(fit$residuals ~ gnat$body,
     xlab = "predictor",
     ylab = "residual",
     cex = .5, cex.lab=.5, cex.axis=.5,
     ylim=c(-200,200),
     pch=16)
abline(h=0, col="red",lwd=.7)

set.seed(1)
x <- runif(min=0, max=800, 171)
y <- rnorm(171, mean=0, sd=x/80)
plot(y ~ x,
     xlab = "predictor",
     ylab = "residual",
     cex = .5, cex.lab=.5, cex.axis=.5,
     ylim=c(-20,20),
     pch=16)
abline(h=0, col="red",lwd=.7)

set.seed(4)
x <- runif(min=-10, max=10, 200)
y <- 55 + rnorm(200, mean=-x^2, sd=abs(4*x))
plot(y ~ x,
     xlab = "predictor",
     ylab = "residual",
     cex = .5, cex.lab=.5, cex.axis=.5,
     #ylim=c(-20,20),
     pch=16)
abline(h=0, col="red",lwd=.7)

x <- gnat$body[1:25]
y <- gnat$horns[1:25]
x2 <- c(gnat$body[1:25], 4400)
y2 <- c(gnat$horns[1:25], 300)

plot(y~x,
     xlab = "predictor",
     ylab = "residual",
     cex = .5, cex.lab=.5, cex.axis=.5,
     pch=16)
abline(lm(y~x))
points(x=4400,y=300,col="red",pch=16,cex=.5)
abline(lm(y2~x2),col="red")
plot(y2~x2,
     xlab = "predictor",
     ylab = "residual",
     cex = .5, cex.lab=.5, cex.axis=.5,
     pch=16)
summary(lm(y2~x2))
summary(lm(y~x))
