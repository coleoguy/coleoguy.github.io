# Heath Blackmon
# Midterm review

cv19 <- matrix(c(32,968,6,994),
               2, 2)
chisq.test(cv19)

x <- runif(100, min=20, max=30)
y <- rnorm(100, mean = x, sd = 2)
z <- runif(100, min=1, max=100)
sex <- as.factor(sample(c("male", "female"), 100, replace =T))
library(viridis)
plot(y~x,
     xlab="Temperature (C)",
     ylab="Offspring number",
     pch=c(3,16)[as.numeric(sex)],
     col=viridis(100)[z],
     yaxt="n")
axis(side=2, at=seq(from=18, to=36, by=4),
     labels=c(1,2,3,4,5))

# You measure height of students at the MSC and the gym.
# Are the heights you measured significantly different
msc <- c(126, 164, 148, 120, 178, 183)
gym <- c(151, 109, 151, 174, 118, 136)
dat <- c(msc, gym)

stat <- c()
for(i in 1:10000){
  x <- sample(dat)
  stat[i] <- mean(x[1:6])-mean(x[7:12])
}
plot(density(stat))
abline(v=mean(dat[1:6])-mean(dat[7:12]))


#What test did you use for this question? ________________
#What p-value was associated with this test? _____________
#What do you infer from your test? _____________________
t.test(msc,gym)
# You grow plants with three different potting soils and measure
# height at 21 days. Describe the results of your study.
Soil1 <- c(23, 12, 45, 23, 21, 45, 21)
Soil2 <- c(35, 45, 21, 34, 67, 23, 16)
Soil3 <- c(16, 21, 18, 33, 16, 21, 19)
heights <- c(Soil1, Soil2, Soil3)
cond <- rep(c("A","B","C"), each=7)
fit <- anova(lm(heights~cond))
fit
# Stickleback fish occur in deep water and shallow water populations.
# These populations rarely interbreed. It has been
# hypothesized that these fish have genetic adaptations to their habitat.
# To test this, you grow fish from both strains in
# both deep and shallow water. Does the data below support the
# hypothesis that these fish are adapted to their natural
# habitat? The values in the table are fitnesses for fish in your experiment
h <- c(rep("hd", 6), rep("hs", 6),rep("hd", 6), rep("hs", 6))
gd <- c(.97, .78, .99, .87, .91, .89, .61, .87,.88, .78, .80, .37)
gs <- c(.56, .95,.73, .81, .89, .64, .77, .95,.93, .95, .89, .94)
dat <- data.frame(c(gd,gs),
                  h,
                  rep(c("gd","gs"),each=12))
colnames(dat) <- c("fitness", "habitat", "genotype")
dat2 <- dat
dat2$habitat <- as.factor(dat2$habitat)
dat2$genotype <- as.factor(dat2$genotype)
library(car)
fit1 <- lm(dat2$fitness ~ dat2$habitat * dat2$genotype)
fit2 <- Anova(lm(dat2$fitness ~ dat2$habitat * dat2$genotype), type="III")
summary(fit1)
fit2

# You measure reproductive success of fish in your study you use fat
# body measure as a correlate of health and record sex
# and number of offspring that survive to adulthood for each fish in
# the study. Interpret the results of your analysis of this
# data.
fb <- c(0.65, 0.35, 0.65, 0.41, 0.62, 0.42, 0.64, 0.51, 0.49, 0.64,
        0.25, 0.68, 0.8, 0.23, 0.63, 0.48, 0.28, 0.71, 0.61, 0.36)
sx <- c("f", "m", "f", "f", "m", "f", "f", "f", "m", "m",
        "m", "m", "m", "f", "m", "m", "f", "m", "f", "f")
repro <- c(10, 16, 9, 8, 0, 9, 9, 9, 8, 3, 17,
           14, 17, 8, 9, 18, 8, 7, 7, 8)
fit <- glm(repro~fb + sx)
summary(fit)
boxplot(repro~sx)
