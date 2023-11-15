smoker <- sample(x=c(T,F), size=1000, replace=T)
coffee <- rep(NA, 1000)
coffee[smoker] <- sample(x=c(T,F), size=sum(smoker), replace=T, prob=c(.9,.1))
coffee[!smoker] <- sample(x=c(T,F), size=sum(!smoker), replace=T, prob=c(.1,.9))
sum(coffee[smoker])/sum(smoker)
sum(coffee[!smoker])/sum(!smoker)
set.seed(10)
age <- round(rnorm(n=1000, mean=50, sd=10))
risk <- age/(5*max(age)) + smoker*.1
C <- c()
for(i in 1:1000){
  C[i] <- sample(x=c(T,F), size=1, replace=T, prob=c(risk[i], 1-risk[i]))
}

dat <- data.frame(C, smoker, coffee, age)
fit <- glm(dat$C~dat$smoker + dat$coffee + dat$age, family = binomial)
summary(fit)
fit <- glm(dat$C~dat$smoker + dat$age, family = binomial)
summary(fit)
fit <- glm(dat$C~dat$coffee + dat$age, family = binomial)
summary(fit)

write.csv(dat, row.names = F, file="smokers.csv")
