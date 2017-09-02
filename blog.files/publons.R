library(car)
library(plotrix)
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

prop <- as.numeric(pub.dat[1,])/sum(as.numeric(pub.dat[1,]))
plot(prop ~ as.numeric(dist.dat[1,]),
     ylab="proportion of reviews",
     xlab="distance to reviewing country", 
     pch=16,cex=.75,col=rgb(1,0,0,.5),
     ylim=c(0,.33))

prop <- as.numeric(pub.dat[52,])/sum(as.numeric(pub.dat[52,]))
points(prop ~ as.numeric(dist.dat[52,]),cex=.75,pch=16, col=rgb(0,0,1,.5))
draw.ellipse(x=16000,y=.066,a = 300,b=.02)
text(x=15000,y=.1,"Australia")
draw.ellipse(x=5700,y=.082,a = 500,b=.01)
text(x=5700,y=.11,"UK")
points(x=rep(10000,2),y=c(.3,.28),pch=16,col=c(rgb(1,0,0,.5), rgb(0,0,1,.5)))
text(x=rep(10000,2),y=c(.3,.28),labels=c("Canada","US"),pos=4)

z.us<-round(sort(pub.dat[52,]/sum(pub.dat[52,]),decreasing = T),digits=2)
z.ca<-round(sort(pub.dat[1,]/sum(pub.dat[1,]),decreasing = T),digits=2)

totals <- rowSums(pub.dat)
sum(totals > 100)
self <- diag(as.matrix(pub.dat))

hist() / )
