dat <- read.csv("retrogene.csv")

parents <- daughters <- matrix(0, 10000, 10)
colnames(parents) <- colnames(daughters) <- colnames(dat)[2:11]

for(i in 1:10000){
  print(i)
  par.probs <- unlist(dat[1, 2:11] / dat[1, 12])
  cur.parents <- sample(1:10, size = 142, replace = T, prob = par.probs)
  dau.probs <- unlist(dat[2, 2:11] / dat[2, 12])
  cur.daughters <- sample(1:10, size = 142, replace = T, prob = par.probs)
  cur.parents <- as.data.frame(table(cur.parents))
  cur.daughters <- as.data.frame(table(cur.daughters))
  parents[i, cur.parents$cur.parents] <- cur.parents$Freq
  daughters[i, cur.daughters$cur.daughters] <- cur.daughters$Freq
}

par(mfcol=c(2,5))
for(i in 1:10){
  hist(parents[,i], main=paste("Lg",i,sep=""))
  abline(v=dat[3,(i+1)], col="red")
}


for(i in 1:10){
  print(sum(parents[,i] >= dat[3,(i+1)])/ 10000)
}

for(i in 1:10){
  print(sum(daughters[,i] >= dat[4,(i+1)])/ 10000)
}


plot(par.probs~dau.probs)
abline(a=0,b=1)
fit <- lm(unlist(dat[1,2:11])~unlist(dat[2,2:11]))
plot(unlist(dat[1,2:11])~unlist(dat[2,2:11]),
     xlab="chromosome size",
     ylab="number of genes")
abline(fit)

