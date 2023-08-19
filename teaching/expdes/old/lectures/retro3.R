dat <- read.csv("retrogene3.csv")
res <- matrix(NA, 100000, 2)
colnames(res) <- c("par","dau")
parprob <- as.numeric(dat[1, 2:11] / dat[1, 12])
dauprob <- as.numeric(dat[2, 2:11] / dat[2, 12])
for(i in 1:100000){
  res[i, 1] <- sum(1 == sample(1:10, replace=T, size=142, prob = parprob))
  res[i, 2] <- sum(1 == sample(1:10, replace=T, size=142, prob = dauprob))
}
pval.par <- sum(res[,1]>= dat[3,2])/100000
pval.dau <- sum(res[,2]>= dat[3,2])/100000

