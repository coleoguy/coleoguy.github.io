# Monte Carlo

# read in the data
dat <- read.csv("retrogene.csv", row.names = 1)

# iter
iter <- 1000
p1 <- p2 <- c()
for(q in 1:1000){
  # we will store our null in a matrix
  null <- matrix(NA, iter, 2)
  colnames(null) <- c("parents", "daughters")

  parent.probs <- as.numeric(dat[1,1:10]/dat[1,11])
  daughter.probs <- as.numeric(dat[2,1:10]/dat[2,11])
  # plot(parent.probs~daughter.probs, cex=.1, xlim=c(0,.25),ylim=c(0,.25))
  # text(x=daughter.probs,y=parent.probs, labels=1:10)
  # lines(x=0:1,y=0:1)
  for(i in 1:iter){
    null[i, 1] <- sum(sample(1:10, size= dat[3, 11],
                             replace=T, prob=parent.probs)==3)
    null[i, 2] <- sum(sample(1:10, size= dat[4, 11],
                             replace=T, prob=daughter.probs)==3)
  }
  # plot(density(null[,1]))
  # abline(v = dat[3, 3], col="red")
  p1[q] <- sum(null[,1] >= dat[3, 3])/iter
  # plot(density(null[,2]))
  # abline(v = dat[4, 3], col="red")
  p2[q] <- sum(null[,2] >= dat[4, 3])/iter
}
