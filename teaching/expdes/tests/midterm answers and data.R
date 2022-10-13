# midterm test work

# R Questions
# You cross a pair of butterflies (ZW sex determination 
# system) and discover that you have 48 males and 32 
# females. You want to know if this data provides evidence 
# for a sex ratio different from 50:50. What p-value 
# would you report for this test. Round your answer 
# to the nearest hundredth (e.g. 0.05)

binom.test(48, 80)
binom.test(32, 80)
# 0.09291
# 0.09

# Now suppose that your question was not whether the 
# sex ratio was 50:50 but whether this data supported 
# Haldanes rule. 

# Note: Haldanes rule states that in a cross when one 
# sex is absent or present in reduced numbers it will 
# be the heterogametic sex. In a ZW system females are 
# the heterogametic sex.

# If this was your question and your reason for 
# performing the experiment what p-value would you 
# report?

binom.test(32, 80, alternative = "l")
binom.test(48, 80, alternative = "g")
# 0.04646
# 0.05

# You are testing a two weed killing compounds.
# 
# 1) You count total number of weeds in each of your 
# experimental plots.
# 
# 2) You apply one weed killing compound to each plot.
# 
# 3) You come back in two weeks and calculate number 
# of weeds killed
# 
# Your data looks like this:
#   
#                            Weed killer 1	Weed killer 2
# Original number of weeds    	475	            459
# Number of weeds killed	      340	            269
# 
# You want to report whether the weed killers worked differently. 
# What p-value will you be reporting? Round your answer 
# to the nearest hundredth (e.g. 0.05)

dat <- matrix(c(475,340,459,269), 2, 2)
chisq.test(dat)
# 0.06

# You are interested in the effectiveness of two UV 
# sterilizers that say they will sterilize your cell 
# phone. You design an experiment where each day you 
# sterilizer your phone in one of the two sterilizers 
# for the recommended 10 minutes and then swab it and 
# inoculate a plate. Later you count the number bacteria 
# colonies that grew in each culture. Download the 
# datafile (phone-microbes.csv) from the course website 
# and select the interpretation that best matches the 
# results of your analysis.

set.seed(3)
ster.A <- round(rnorm(15, mean = 23, sd = 5))
ster.B <- round(rnorm(15, mean = 27, sd = 5))
dat <- data.frame(ster.A,ster.B)
write.csv(dat,file="phone-microbes.csv", row.names = F)
dat <- read.csv("phone-microbes.csv")
t.test(x=dat$ster.A, y=dat$ster.B)
t.test(x=dat$ster.A, y=dat$ster.B, alternative="g")
t.test(x=dat$ster.A, y=dat$ster.B, alternative="l")

# 0.02287
# 0.02

# 
# In the cricket dataset we evaluate the number offspring 
# that two strains of crickets produce. You think that the 
# strain "42" produces more offspring than the strain "76". 
# Unfortunately you data violates the assumptions of a 
# two sample t-test. Download the dataset from the 
# course website (crickets.csv) and use a permutation 
# test to determine 
# whether the two strains have different mean number of 
# offspring. For your permutation test perform 1000 
# iterations. Answer this and the next two questions 
# based on this data? Round all answers to then nearest 
# hundredth (e.g. 0.05)
# 
# 1) When you use permutations to create a null 
#    distribution of the difference in the means of the 
#    two strains what is the average of that null 
#    distribution?
#   
# 2) What is your observed statistic for the difference 
#    in the mean?
#   
# 3) What p-value would you report in discussing whether 
#    strain 42 produces more offspring than strain 76?
# 
# 


set.seed(1)
strain42 <- rpois(50, 308)
strain76 <- rpois(50, 300)
crickets <- data.frame(c(strain42,strain76),
                       rep(c("strain42","strain76"),each=50))
colnames(crickets) <- c("offspring","strain")
write.csv(crickets, "crickets.csv", row.names = F)
dat <- read.csv("crickets.csv")

emp.dif <- mean(dat$offspring[dat$strain=="strain42"]) - 
  mean(dat$offspring[dat$strain=="strain76"])
#  6.60

null.dist1 <- null.dist2 <- c()
for(i in 1:1000){
  newstrain <- sample(dat$strain)
  null.dist1[i] <- mean(dat$offspring[newstrain=="strain42"]) - mean(dat$offspring[newstrain=="strain76"])

  newvals <- sample(dat$offspring)
  null.dist2[i] <- mean(newvals[1:50]) - mean(newvals[51:100])
}

mean(null.dist1)
mean(null.dist2)
# -0.5 to 0.5

sum(null.dist1>=emp.dif)/1000
sum(null.dist2>=emp.dif)/1000
# 0 to 0.03



pvals <- c()
nulldistmeans <- c()
min.pval <- max.pval <- c()
for(q in 1:100){
  print(q)
  for(j in 1:1000){
    null.dist <- c()
    for(i in 1:1000){
      newvals <- sample(dat$offspring)
      null.dist[i] <- mean(newvals[1:50]) - mean(newvals[51:100])
    }
    nulldistmeans[j] <- mean(null.dist)
    pvals[j] <- sum(null.dist>=emp.dif)/1000
  }
  min.pval[q] <- min(pvals)
  max.pval[q] <- max(pvals)
}

range(min.pval)
# 0.003 to 0.007
range(max.pval)
# -0.028  to 0.036


