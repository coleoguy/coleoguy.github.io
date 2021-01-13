setwd("~/Downloads")
dat <- read.csv("final1 (1).csv")

fit <- glm(dat$size ~ dat$day + dat$sex + dat$food + abs(37-dat$temp))
summary(fit)
temp <- (37-dat$temp)
fit2 <- glm(dat$size ~ dat$day^2 + dat$sex + dat$food + temp + dat$incubator)
summary(fit2)

starts <- seq.int(from=1, by=30, length.out=200)
finals <- seq.int(from=30, by=30, length.out=200)
dat2 <- dat[finals,]
mean.temps <- c()
for(i in 1:200){
  mean.temps[i] <- mean(abs(37-(dat$temp[starts[i]:finals[i]])))
}

dat2$temp <- mean.temps
fit <- glm(dat2$size ~ dat2$sex + dat2$food + dat2$temp +dat2$incubator)
summary(fit)
library(ggraptR)
ggraptR(dat2)


ggplot(dat2, aes(y=size, x=as.factor(food))) + 
  geom_boxplot(aes(fill=as.factor(sex)), stat="boxplot",  
               position=, alpha=0.5, width=1, outlier.shape = NA) + 
  geom_dotplot(binaxis='y', aes(fill=as.factor(sex)),stackdir='center', 
               dotsize=.5,position=position_dodge(1), alpha=.5) +
  facet_grid(. ~ temp) + 
  theme_bw() + 
 # theme(text=element_text(family="sans", face="plain", color="#000000", size=15, hjust=0.5, vjust=0.5)) + 
  guides(fill=guide_legend(title="sex")) + xlab("Type of flour") + ylab("Size (mm)")





