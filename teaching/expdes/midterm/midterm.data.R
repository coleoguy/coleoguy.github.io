# you are interested in whether different majors
# have different probabilities of accepting a
# covid-19 vaccine to do this you survey 200 students from
# each of 5 majors

dat <- matrix(,2,5)
colnames(dat) <- c("Biology", "Math", "Business", "Management", "Engineering")
row.names(dat) <- c("accept", "reject")
for(i in 1:5){
  set.seed(i)
  dat[1, i] <- rpois(1, 180)
  dat[2, i] <- 200 - dat[1, i]
}
chisq.test(dat)
write.csv(dat, file="vac.rates.csv")

# You sample birds from two field sites. At each site you count the
# number of nasal mites that are found in each bird. Determine whether
# the parasite load is the same for your two samples of birds

set.seed(1)
site1 <- round(rnorm(15, mean=10, sd=4))
site2 <- round(rnorm(23, mean=13, sd=4))
dat <- data.frame(c(site1, site2),
                  c(rep(1, 15), rep(2, 23)))
colnames(dat) <- c("count", "site")
t.test(site1, site2)
write.csv(dat, file="mite.count.csv")

# You are interested in the impact of different feeds on
# the growth of chickens. Identify the feed that leads to
# the highest mean weight and all other feeds that are not
# significantly different from this feed.
dat <- chickwts
types <- unique(dat$feed)
means <- c()
for(i in 1:length(types)){
  means[i] <- mean(dat$weight[dat$feed == types[i]])
}
names(means) <- as.character(types)
means <- means[order(means)]
# sunflower is highest
fit <- anova(lm(dat$weight~dat$feed))
fit <- aov(lm(dat$weight~dat$feed))
TukeyHSD(fit)



# you are interested in what determines the reproductive success of
# of betta fish. You have recorded size, color intensity, and strain
# information for each fish. Determine which variable(s) is predictive of
# reproductive success.
sampsize <- 200
body.length <- rnorm(sampsize, mean=5.7, sd = 1)
color.int <- sample(rnorm(sampsize, mean = 129, sd = 35))
strain <- as.factor(sample(c("veil", "crown", "plakat", "spade"), sampsize, replace=T))
ID <- 1:sampsize
strain.effect <- as.numeric(strain)
strain.effect[strain.effect != 3] <- 0
offspring <- rnorm(sampsize, mean = (body.length*.25), sd=.25) +
             rnorm(sampsize, mean = (color.int*.05)) +
             rpois(sampsize, as.numeric(strain.effect))
dat <- data.frame(ID, offspring, body.length, color.int, strain)
plot(dat)
dat$offspring <- round(dat$offspring)
fit <- glm(dat$offspring ~ dat$body.length + dat$color.int + dat$strain)
summary(fit)
write.csv(dat, "betta.csv")
