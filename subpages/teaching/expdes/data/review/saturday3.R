# Saturday Coding Extravaganza
# Monte Carlos and Unsolved Mystries
# Heath Blackmon
# 23 November 2024
# coleoguy@gmail.com



# GO Terms
dat <- read.csv("GOdata.csv")
res <- read.csv("GOgenes.csv")

# extract the GO Terms for the genes identified
# in my RNA sequencing experiment
empGO <- dat$GOterms[dat$GeneID %in% res$RNA.Seq.Diff.Exp]
# lets get a null
set.seed(5)
null <- matrix(NA, 100000, 2)
colnames(null) <- c("angio", "P53")
for(i in 1:100000){
  x <- sample(dat$GOterms, 9)
  null[i, 1] <- sum(x == "Angiogenesis")
  null[i, 2] <- sum(x == "Signal transduction by p53 class mediator")
}
sum(null[,1] >= 3) / 100000
sum(null[,2] >= 4) / 100000

# in my Selection Scan Experiment
empGO <- dat$GOterms[dat$GeneID %in% res$Seln.Scan]
# lets get a null
set.seed(5)
null <- matrix(NA, 100000, 2)
colnames(null) <- c("metab", "neuro")
for(i in 1:100000){
  x <- sample(dat$GOterms, 6)
  null[i, 1] <- sum(x == "Metabolic process")
  null[i, 2] <- sum(x == "Neurogenesis")
}
obs.neuro <- sum(empGO == "Neurogenesis")
obs.metab <- sum(empGO == "Metabolic process")
sum(null[,1] >= obs.metab) / 100000
sum(null[,2] >= obs.neuro) / 100000

# Logistic Regression
dat <- read.csv("hybridization.csv")[-124,]
# 0 = no haldanes rule 1=haldanes rule
# 0=cant hybridize 1= can hybridize
dat <- dat[dat$HaldanesRule != "",]
dat$HaldanesRule <-  as.numeric(dat$HaldanesRule)

dat <- data.frame(x=dat$divergence, y=dat$HaldanesRule)
fit <- glm(y ~ x, data = dat, family = "binomial")
# create new X values (divergences) to evaluate
newdat <- data.frame(x=seq(from=0.105, to=31, length.out=83))
# get the expected probabilities
newdat$predicted_prob <- predict(fit, newdata = newdat, type = "response")
plot(dat$y~dat$x, pch=16, col="darkblue")
lines(newdat$predicted_prob~newdat$x)
# to get the 50% probability of exhibiting haldanes rule
newdat$x[which(newdat$predicted_prob>=.5)[1]]




