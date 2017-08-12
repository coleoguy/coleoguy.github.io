library(car)
pub.dat <- read.csv("publons.csv",row.names=1, as.is=T)
dist.dat <- read.csv("distances.csv",row.names=1, as.is=T)
wfc.dat <- read.csv("wfc.csv",row.names=1, as.is=T)

reviews <- log(colSums(pub.dat))
editors <- log(rowSums(pub.dat))
reviews[reviews==-Inf] <- -1
editors[editors==-Inf] <- -1

plot(reviews ~ editors,
     xlab="handling editors", ylab="reviews",
     xlim=c(-1,11), ylim=c(-1,11),xaxt="n",yaxt="n",
     pch=16,cex=.75,col=rgb(1,0,0,.5))
lines(x=c(0,11),y=c(0,11))
axis(side=1,
     at=c(-1,log(c(1,20,200,2000,20000))), 
     labels = c(0,c(1,20,200,2000,20000)))
axis(side=2,
     at=c(-1,log(c(1,20,200,2000,20000))), 
     labels = c(0,c(1,20,200,2000,20000)))

z <- which(editors==-1)[which(editors==-1) %in% which(reviews>-1)]


# now lets slim the data to those with at least 100 editors
big.editors <- as.numeric(which(rowSums(pub.dat) > 100))



plot(reviews[big.editors] ~ editors[big.editors],
     xlab="handling editors", ylab="reviews",
     xlim=c(4.5,11), ylim=c(4.5,11),xaxt="n",yaxt="n",
     pch=16,cex=.75,col=rgb(1,0,0,.5))
lines(x=c(0,11),y=c(0,11))
axis(side=1,
     at=c(-1,log(c(1,20,200,2000,20000))), 
     labels = c(0,c(1,20,200,2000,20000)))
axis(side=2,
     at=c(-1,log(c(1,20,200,2000,20000))), 
     labels = c(0,c(1,20,200,2000,20000)))


# lets get the deviations from this diagonal
raw.reviews <- colSums(pub.dat)
raw.editors <- rowSums(pub.dat)
resids <- raw.reviews - raw.editors

# plot resids
plot(sort(resids[big.editors]), pch=16, cex=.75,col=rgb(1,0,0,.8),
     ylab="reviews - editors",xaxt="n",xlab="")
abline(h=0)

# who are these countries
sort(resids[big.editors])


# standardize relative to the WFC

plot(sort((resids/wfc.dat$WFC)[big.editors]), pch=16, cex=.75,col=rgb(1,0,0,.8),
     ylab="weighted: reviews - editors",xaxt="n",xlab="")
abline(h=0)

sort((resids/wfc.dat$WFC)[big.editors])

# now lets do an ANCOVA
# first we need to munge the data a bit
# so it looks like:
#
# editor   reviewer   count    distance
# Canada   Canada     700     400
# Canada   U.S.       300     1000
# Russia   Italy      3       2300

lmm.dat <- as.data.frame(matrix(,1,5))
counter <- 1
colnames(lmm.dat) <- c("editor", "reviewer", "count", "distance", "wfc")
for(i in 1:112){ # rows editors
  for(j in 1:112){ # columns review counts
    if(pub.dat[i,j]>0){
      lmm.dat[counter, 1] <- row.names(pub.dat)[i]
      lmm.dat[counter, 2] <- colnames(pub.dat)[j]
      lmm.dat[counter, 3] <- pub.dat[i,j]
      lmm.dat[counter, 4] <- dist.dat[i,j]
      lmm.dat[counter, 5] <- wfc.dat$WFC[j]
      counter <- counter + 1
    }
  }
}
model.1 = lm(count ~ distance + wfc + distance:editor,
              data = lmm.dat)
Anova(model.1, type="II")
summary(model.1)


rev.count <- log(lmm.dat$count)
dist.WFC <- log(lmm.dat$pred)
yjit <- 1-jitter(rep(1,1638),factor=1)
plot((rev.count+yjit) ~ dist.WFC,xlab="weighted distance",
     ylab="review count",col=rgb(1,0,0,.6),
     yaxt="n", xaxt="n",pch=16,cex=.5)
axis(side=1,at=c(0,5.29,9.9),labels=c(1,200,20000))
axis(side=2,at=c(1,3.4,8),labels=c(1,30,3000))


library(lme4)
library(arm)
fit <- lmer(count ~ pred + (1 + pred|editor), 
            data = lmm.dat)
display(fit)
summary(fit)
??display

table(lmm.dat$editor)



reg.conf.intervals <- function(x, y) {
  n <- length(y) # Find length of y to use as sample size
  lm.model <- lm(y ~ x) # Fit linear model
  
  # Extract fitted coefficients from model object
  b0 <- lm.model$coefficients[1]
  b1 <- lm.model$coefficients[2]
  
  # Find SSE and MSE
  sse <- sum((y - lm.model$fitted.values)^2)
  mse <- sse / (n - 2)
  
  t.val <- qt(0.975, n - 2) # Calculate critical t-value
  
  # Fit linear model with extracted coefficients
  x_new <- 1:max(x)
  y.fit <- b1 * x_new + b0
  
  # Find the standard error of the regression line
  se <- sqrt(sum((y - y.fit)^2) / (n - 2)) * sqrt(1 / n + (x - mean(x))^2 / sum((x - mean(x))^2))
  
  # Fit a new linear model that extends past the given data points (for plotting)
  x_new2 <- 1:max(x + 100)
  y.fit2 <- b1 * x_new2 + b0
  
  # Warnings of mismatched lengths are suppressed
  slope.upper <- suppressWarnings(y.fit2 + t.val * se)
  slope.lower <- suppressWarnings(y.fit2 - t.val * se)
  
  # Collect the computed confidence bands into a data.frame and name the colums
  bands <- data.frame(cbind(slope.lower, slope.upper))
  colnames(bands) <- c('Lower Confidence Band', 'Upper Confidence Band')
  
  # Plot the fitted linear regression line and the computed confidence bands
  plot(x, y, cex = 1.75, pch = 21, bg = 'gray')
  lines(y.fit2, col = 'black', lwd = 2)
  lines(bands[1], col = 'blue', lty = 2, lwd = 2)
  lines(bands[2], col = 'blue', lty = 2, lwd = 2)
  
  return(bands)
}
pred <- as.numeric(wfc.dat$WFC*dist.dat[1,])
reg.conf.intervals(y=as.numeric(pub.dat[1,]), x=pred)

