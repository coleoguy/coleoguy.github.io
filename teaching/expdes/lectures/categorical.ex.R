# Example of binomial and Chi-Squared

# The binomial test allows us to determine whether 
# the probability of a binary outcome differs
# from an expectation. As an example lets think
# about sex ratio. With typical chromosomal sex
# determination we expect a 50/50 sex ratio. In
# one study we crossed two species and produce 32
# males and 49 females does the sex ratio differ 
# from 50/50?

offspring <- c(32, 49)
names(offspring) <- c("males", "females")
binom.test(x = offspring[1],
           n= sum(offspring),
           p = 0.5)

# in this case we find that sex ratio does not deviate from a 
# 50/50 sex ratio. If instead we had an a priori hypothesis that 
# we expected to see fewer males than females we could use a 
# one tailed test resulting in a different p-value

binom.test(x = offspring[1],
           n= sum(offspring),
           p = 0.5,
           alternative ="l")

# Your question matters and your statistical test must be performed
# in the right way based on your hypothesis and what you are 
# looking to test.

# If we have multiple categories we need to move beyond the 
# binomial test and use the Chi squared test.

# here we create the data for the titanic example from class
dat <- matrix(c(140,80,76,20,4,13,89,3),4,2)
colnames(dat) <- c("survived", "died")
rownames(dat) <- c("1st","2nd","3rd","crew")
chisq.test(dat)



