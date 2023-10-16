# midterm test work

# 11
dat <- read.csv("../Desktop/github/coleoguy.github.io/teaching/expdes/tests/vac.rates.csv")
chisq.test(dat)
chisq.test(dat[,-1])
#

# 13
dat <- read.csv("../Desktop/github/coleoguy.github.io/teaching/expdes/tests/mite.count.csv")
t.test(dat$count~dat$site)
t.test(dat$count[dat$site==1], dat$count[dat$site==2])
#

# 14
dat <- read.csv("../Desktop/github/coleoguy.github.io/teaching/expdes/tests/phone-microbes.csv")
obs.diff <- abs(mean(dat$ster.A) - mean(dat$ster.B))
null <- c()
for(i in 1:1000){
  x <- sample(c(dat$ster.A,dat$ster.B))
  null[i] <- abs(mean(x[1:15]) - mean(x[16:30]))
}
pval <- sum(null>=obs.diff)/length(null)
#

# 16
pvals <- c()
for(j in 1:1000){
  print(j)
  obs.diff <- abs(mean(dat$ster.A) - mean(dat$ster.B))
  null <- c()
  for(i in 1:1000){
    x <- sample(c(dat$ster.A,dat$ster.B))
    null[i] <- abs(mean(x[1:15]) - mean(x[16:30]))
  }
  pvals[j] <- sum(null>=obs.diff)/length(null)
}
range(pvals)

