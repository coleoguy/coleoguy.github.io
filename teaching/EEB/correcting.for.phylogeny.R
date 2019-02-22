# ape contains many useful utility functions for phylogenetics
# rTraitCont simulates a continuous trait
# pic calculates independent contrasts
# rcoal generates a random tree through a coalescent process
# set.seed allows you to get the same set of random results

# set a seed
set.seed(3)

# simulate a tree with 20 tips
tree <- rcoal(20)

# lets look at the tree
# plot(tree)

# we will use this to hold our values
betas <- pvals <- c.betas <- c.pvals <- c()

# this is the number of simulations we will run
nsims <- 10000

# we will generate 10,000 simulated datastes
for(i in 1:nsims){
  
  # simulate two traits that evolve independently
  trait1 <- rTraitCont(phy=tree)
  trait2 <- rTraitCont(phy=tree)
  
  # calculate the correlation between traits
  results <- cor.test(trait1, trait2)
  betas[i] <- results$estimate
  pvals[i] <- results$p.value
}

# here we calculate the false positive rate
fpos <- sum(pvals<=.05)/nsims


# repeat the process with phylogenetic independent contrasts
# again with 10000 simulated datasets
for(i in 1:nsims){
  # simulate two traits that evolve independently
  trait1 <- rTraitCont(phy=tree)
  trait2 <- rTraitCont(phy=tree)
  
  # convert raw values to independent contrasts
  pic.trait1 <- pic(trait1, phy=tree)
  pic.trait2 <- pic(trait2, phy=tree)
  
  # calculate the correlation between our traits
  results <- cor.test(pic.trait1, pic.trait2)
  c.betas[i] <- results$estimate
  c.pvals[i] <- results$p.value
}

# this gives us the false positive rate
c.fpos <- sum(c.pvals<=.05)/nsims


# lets plot our results
# lets set up our plot window to hold four plots
par(mfcol=c(2,2))


# here is the distribution of pvalues
# not correcting for phylogeny
hist(pvals, breaks=50, main="no correction for phylogeny")
abline(v=.05, col="red")
text(x=.6,y=5000, paste("false pos. rate =", fpos),cex=.7)

# here is the distribution of 
# betas not correcting for phylogeny
# notice the excess of nonzero values
hist(betas, breaks=50, main="no correction for phylogeny")

# lets look at the distribution of 
# pvals with correction for phylogeny
hist(c.pvals, breaks=50, main="corrected for phylogeny")
abline(v=.05, col="red")
text(x=.6,y=235, paste("false pos. rate =", c.fpos),cex=.7)

# here is the variation in betas
# correcting for phylogeny
hist(c.betas, breaks=50)
# this looks more like what we want most values are
# clustered around zero
