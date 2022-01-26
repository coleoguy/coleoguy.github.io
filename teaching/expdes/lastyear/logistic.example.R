
# fixed effect model

dat <- read.csv("fish2.csv")

fitness <- unlist(dat)
env <- c(rep("deep", 24), rep("shallow", 24))
geno <- c(rep("deep", 12), rep("shallow", 12),
          rep("deep", 12), rep("shallow", 12))
dat2 <- data.frame(fitness, env, geno)
dat2 <- dat2[complete.cases(dat2),]

#library(ggraptR)
#ggraptR(dat2)

ggplot(dat2, aes(y=fitness, x=as.factor(env))) +
  geom_boxplot(aes(fill=as.factor(geno)), stat="boxplot",
               position=position_dodge(.6), width=0.4) +
  theme_bw() +
  guides(fill=guide_legend(title="Genotype")) +
  xlab("Environment") +
  ylab("Fitness")


fit <- glm(dat2$fitness ~ dat2$env*dat2$geno)
summary(fit)

# mixed effects model

dat <- read.csv("AZ.csv")
library(nlme)
fit <- lme(gloriosa ~ oaks + jun + elev,
           random = list(~1|site, ~1|trip),
           data=dat)
summary(fit)
resids <- fit$residuals[,1]
hist(resids)
plot(dat$gloriosa~dat$date)








