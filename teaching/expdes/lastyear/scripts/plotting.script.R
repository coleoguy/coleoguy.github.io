# heath Blackmon
# examples of types of plots using base R
# coleoguy@gmail.com
# expdes class week 2 class 2

dat <- data.frame(rpois(31,3),
                  rpois(31,5))

dat <- cbind(1:31, dat)
colnames(dat) <- c("days","treatment1","treatment2")
par(bty="l")
plot(x=dat$days,
     y=dat$treatment1,
     type="l",
     ylim=c(0,16),
     lty=2,
     xlab="days post dose",
     ylab="deaths",
     main="comp. of medicines",
     lwd=2,
     col=rgb(80/255,0,0))
lines(x=dat$days, y=dat$treatment2, lwd=2,col="purple")

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

# I think this plot could be improved even more by forgoing the basic
# boxplot here is how I would plot this particular dataset

# first I want to create x values that will allow me to plot
# each species in a different column but with some noise left and
# right.
xvals <- c(runif(50, min=.7, max=1.3),
           runif(50, min=1.7, max=2.3),
           runif(50, min=2.7, max=3.3))

# I also want colors that represent each species 
cols <- c(rep("blue", 50),
          rep("darkgreen", 50),
          rep("darkred", 50))

plot(x = xvals, 
     y = c(petals$setosa, petals$versicolor, petals$virginica),
     col = cols, pch = 16, xaxt="n", ylab = "Length(cm)", 
     xlab = "")

# if you didnt want to use color you could use this line to put titles on
# the x axis.
# axis(side = 1, at = 1:3, labels = colnames(petals))

# instead I will plot a legend manually
points(x=c(.7,.7,.7),y=c(2.0,2.2,2.4), pch=16,cex=1.3,col=c(cols[c(1,51,101)]))
text(x=c(.7,.7,.7),y=c(2.0,2.2,2.4), labels = colnames(petals),
     cex=1.1,pos=4)

# I'd like to add to this the 95% confidence interval on top of these points
set.error <- qnorm(0.975)*sd(petals$setosa)/sqrt(50)
set95 <- c(mean(petals$setosa) - set.error,
           mean(petals$setosa) + set.error)
ver.error <- qnorm(0.975)*sd(petals$versicolor)/sqrt(50)
ver95 <- c(mean(petals$versicolor) - ver.error,
           mean(petals$versicolor) + ver.error)
vir.error <- qnorm(0.975)*sd(petals$virginica)/sqrt(50)
vir95 <- c(mean(petals$virginica) - vir.error,
           mean(petals$virginica) + vir.error)
arrows(x0 = 1, x1 = 1, y0 = set95[1], y1 = set95[2],
       angle = 90, lwd = 3, code = 3, length = .45)
arrows(x0 = 2, x1 = 2, y0 = ver95[1], y1 = ver95[2],
       angle = 90, lwd = 3, code = 3, length = .45)
arrows(x0 = 3, x1 = 3, y0 = vir95[1], y1 = vir95[2],
       angle = 90, lwd = 3, code = 3, length = .45)


# scatterplots
plot(x=iris$Petal.Width, 
     y=iris$Petal.Length,
     pch=16,
     cex=.7,
     col=c(rep(rgb(0,0,1,.6), 50),
           rep(rgb(0.1,.8,.4,.6), 50),
           rep(rgb(1,0,0,.6), 50)))
abline(v=.7, lty=2)

# scatterplot with regression line
plot(x=iris$Petal.Width, 
     y=iris$Petal.Length,
     pch=16,
     cex=.7,
     col=c(rep(rgb(0,0,1,.6), 50),
           rep(rgb(0.1,.8,.4,.6), 50),
           rep(rgb(1,0,0,.6), 50)))
abline(lm(iris$Petal.Length~iris$Petal.Width), col="gray", lwd=2)
# example of how to add on symbols
text(x=.1,y=6.5,labels = expression(paste(beta, "=2.23")), pos=4)


# mosaicplots
surv.dat <- matrix(c(7,16,23,14),2,2)
row.names(surv.dat) <- c("strain1", "strain2")
colnames(surv.dat) <- c("survived", "died")
mosaicplot(surv.dat, col=c("red","darkred"))


