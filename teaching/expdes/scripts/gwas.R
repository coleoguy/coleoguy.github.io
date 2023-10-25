# example of GWAS

# First lets think of what the data going into GWAS looks like
# you normally only analyze biallelic SNP data where the rare allele
# has a minimum frequency of 0.05. So a sample will
# essentially consist of 1, 2, 3 denoting if the genotype at a site
# is homozygous for common variant, heterozygous, or homozygous for
# the rare allele.

# lets create 200 toy genomes with 4,000 SNPs
dat <- matrix(NA, 200, 4000)

# now lets use a loop to fill in these genomes
# at each site we will pick a random allele frequency for
# the common allele and assign genotypes assuming HW equilibrium
for(i in 1:4000){
  p <- runif(1, min = .5, max=.95)
  q <- 1-p
  dat[, i] <- sample(1:3, size=200, replace=T, prob=c(p^2, 2*p*q, q^2))
}


# now lets imagine that we have a trait that is controlled
# by a gene that includes 4 SNPs randomly chose from the genome
set.seed(1)
chosenSNPs <- sample(1:4000, 4)

# now we create our phenotype measured for each individual
# based on the genotype that they carry at the 4 loci chosen
y <- rnorm(200, mean=2*rowSums(dat[, chosenSNPs]-1), sd=1)
plot(y~dat[,2177])

# now lets see if we can recover this by running a GWAS
pvals <- c()

# here we will loop across the genome and preform a glm
# testing the genotypes as a predictor for the phenotype
# we are interested in.
for(i in 1:4000){
  pvals[i] <- summary(lm(y ~ dat[,i]))$coefficients[2,4]
}

par(mfcol=c(1,1))

# this shows us the distribution of p-values for
# all loci
hist(pvals)

# lets make a vector of colors that is red if the
# pvalue is less than 0.05 and black otherwise
cols <- rep("black", 4000)
cols[pvals < 0.05] <- "red"
plot(pvals, cex=.1, col=cols)
abline(h=.05, lty=2, col="blue")
sum(pvals<0.05)

# one of the characteristics of -logged values is that as the number
# goes to zero the -log of the number begins to increase disproportionately
logged <- -1*log(seq(from=0.0000001, to=1, length.out = 4000))
unlogged <- seq(from=0.0000001, to=1, length.out = 4000)
plot(logged~unlogged, xlim=c(0,.05))

# ok so lets look at the pvalues from our GWAS
plot(-1*log(pvals, base=10), cex=.2, ylab="-log10(pvalue)")

# lets plot red lines to find our SNPs that contribute to the phenotype
for(i in 1:4){
  abline(v=chosenSNPs[i],col="red",lwd=.3)
}

# this is that arbitrary cutoff I mentioned
abline(h=-1*log(5*10^-8, base=10),lty=3)
which(pvals<5*10^-8)
# our ability to detect a SNPs contribution are
# dependent on genotype frequencies in our
# sample.
par(mfcol=c(2,2))
for(i in 1:4){
  hist(dat[,chosenSNPs[i]],
       main=paste("site:",chosenSNPs[i]),
       xlab="genotypes",
       xaxt="n")
  axis(side=1, at=1:3, labels = 1:3)
}

