# Binomial
dat <- read.csv("reproductive_isolation.csv")
dat$outcome <- as.factor(dat$outcome)
fit <- glm(dat$outcome ~ dat$divergence_mya, family="binomial")
summary(fit)
newdat <- data.frame(divergence_mya = seq(min(dat$divergence_mya),
                                          max(dat$divergence_mya), 
                                          length = 100))
newdat$pred <- predict(fit, newdata = newdat, 
                       type = "response")
plot(x=dat$divergence_mya, y=as.numeric(dat$outcome)-1,
     yaxt="n", ylab="", pch=16, cex=.5, col="pink")
axis(side=2, at=c(0,1), labels=c("fertile","infertile"), las=2)
lines(x=newdat$divergence_mya, y=newdat$pred, 
      col="purple")


