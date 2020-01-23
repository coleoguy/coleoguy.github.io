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
# boxplots
# scatterplots
# matrixplots