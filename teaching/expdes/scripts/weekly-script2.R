# R comes with lots of data lets get some to play with
data("iris")

# here we write this data to the working directory
write.csv(iris, "iris.csv", row.names = F)

# here we read a file from our working directory
dat <- read.csv("iris.csv")

# installing packages
# you can install packages by using the packages tab and
# clicking the install button.
# packages you could use soon: viridis, beeswarm
# packages we will use later: ggplot2, ggraptR

# lets explore some plotting functions
# get some data
dat <- read.csv("iris.csv")

# there are three species here so lets go with 
# three colors that we could use.
cols <- c("#8dd3c7", "#ffffb3", "#bebada")

# here we build the base plot
plot(dat$Petal.Length ~ dat$Petal.Width,
     xlab="Petal width",
     ylab="Petal length",
     pch=16,
     col=cols[as.factor(dat$Species)],
     cex=.75)

# now lets build a legend first with colors
points(x=1.9, y=3, pch=16, col=cols[1])
points(x=1.9, y=2.5, pch=16, col=cols[2])
points(x=1.9, y=2, pch=16, col=cols[3])

# here we add text to our legend
text(x=1.9, y=3, 
     paste("Iris", unique(dat$Species)[1]), 
     pos=4, cex=.7)
text(x=1.9, y=2.5, 
     paste("Iris", unique(dat$Species)[2]), 
     pos=4, cex=.7)
text(x=1.9, y=2, 
     paste("Iris", unique(dat$Species)[3]), 
     pos=4, cex=.7)

# lets look at how we can use the density function
# in conjunction with the plot function
plot(density(dat$Petal.Length))

# abline is a simple function for adding lines to a plot
abline(v=2.9, col="red")
abline(h=.1, col="blue", lwd=3, lty=2)

# lets look at a barplot
# lets simulate some count data
dat <- rpois(5, 123)
names(dat) <- c("a","b","c","d","e")
# and now make the plot
barplot(dat)

# lets look at a more nuanced use of density function
dat1 <- rnorm(1000)
dat2 <- rnorm(1000, mean=1)
library(viridis)
cols <- viridis(20, alpha=.5)
plot(density(dat1),xlim=c(-5,5),
     ylim=c(0,.5), main="")
lines(density(dat2))
polygon(density(dat1), col=cols[4])
polygon(density(dat2), col=cols[13])



# Exporting plots
dat <- rnorm(1000, mean=10)
plot(density(dat),
     main="")

# Nice boxplot
grades <- c(runif(50, 45, 110),
            runif(50, 45, 90))
status <- rep(c("pre", "post"),
              each=50)


boxplot(grades ~ status,
        col="white")
points(x=rnorm(50, mean=1, sd=.1),
       y=grades[status == "post"],
       pch=16, cex=.75, col="lightgray")
points(x=rnorm(50, mean=2, sd=.1),
       y=grades[status == "pre"],
       pch=16, cex=.75, col="lightgray")

# Beeswarm
library(beeswarm)
boxplot(grades~status, col="white", boxwex=.5)
beeswarm(grades~status, add=T,
         pch=16, cex=.8,
         col=rgb(0,0,0,.5))

# make a plot
# 5"x5"
# PDF
# show the data

