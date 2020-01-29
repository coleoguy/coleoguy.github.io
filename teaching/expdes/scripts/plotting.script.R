# heath Blackmon
# examples of types of plots using base R
# coleoguy@gmail.com
# expdes class week 2 class 2

dat <- read.csv("play.dat.csv")
dat <- cbind(1:31, dat)
colnames(dat)[1] <- "days"
par(bty="l")
plot(x=dat$days,
     y=dat$Treatment1,
     type="l",
     ylim=c(0,16),
     lty=2,
     xlab="days post dose",
     ylab="deaths",
     main="comp. of medicines",
     lwd=2,
     col=rgb(80/255,0,0))
lines(x=dat$days, y=dat$Treatment2, lwd=2,col="purple")

# barplots
disp.beetles <- c(10, 12, 34, 31)
names(disp.beetles) <- c("Line 1", "Line 2", 
                         "Line 3", "Line 4")
barplot(disp.beetles,
        ylab="count",
        ylim=c(0,40),
        col=c("green", "green", 
              rgb(80,0,0, maxColorValue = 255), 
              "blue"))

# boxplots
data(iris)
petals <- data.frame(iris$Petal.Width[1:50],
                     iris$Petal.Width[51:100],
                     iris$Petal.Width[101:150])
colnames(petals) <- unique(iris$Species)
boxplot(petals,
        outline=F)
points(x=runif(50, min=.7, max=1.3), 
       y=petals[,1],
       col=rgb(0,0,0,.7),
       pch=16,
       cex=.5)
points(x=runif(50, min=1.7, max=2.3), 
       y=petals[,2],
       col=rgb(0,0,0,.7),
       pch=16,
       cex=.5)
points(x=runif(50, min=2.7, max=3.3), 
       y=petals[,3],
       col=rgb(0,0,0,.7),
       pch=16,
       cex=.5)

# scatterplots
plot(x=iris$Petal.Width, 
     y=iris$Petal.Length,
     pch=16,
     cex=.7,
     col=c(rep(rgb(0,0,1,.6), 50),
           rep(rgb(0.1,.8,.4,.6), 50),
           rep(rgb(1,0,0,.6), 50)))
abline(v=.7, lty=2)

# mosaicplots
surv.dat <- matrix(c(7,16,23,14),2,2)
row.names(surv.dat) <- c("strain1", "strain2")
colnames(surv.dat) <- c("survived", "died")
mosaicplot(surv.dat, col=c("red","darkred"))
