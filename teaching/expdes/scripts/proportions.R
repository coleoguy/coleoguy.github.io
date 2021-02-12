# here we create a data vector containing the number
# of male and female offspring from the experiment
offspring <- c(52, 74)
# this assigns names to each of the elements of our
# vector
names(offspring) <- c("male","female")

# this performs the binomial test based on the
# a priori assumption that we are testing whether
# there are fewer males than we would expect
# given a 50/50 sex ratio.
binom.test(x = offspring[1],
           n = sum(offspring),
           alternative = "l")

# if instead we were simply just testing for a
# deviation of 50/50 sex ratio it would be appropriate
# to perform a two sided test.
binom.test(x = offspring[1],
           n = sum(offspring))

# and here is a simple barplot of the data
barplot(offspring, main="Offspring distribution")


# this loop will cycle through binomial tests
# with an increasing number of offspring and
# the most extreme sex ratio possible (all
# of one sex and no individuals of the second
# sex.) Each time we run the binomial test we
# extract the pvalue with $p.value
pvals <- c()
for(i in 1:20){
  pvals[i] <- binom.test(0, i)$p.value
}

# with this vector of p-values we now can
# look to see the first value that is less
# than 0.05
min(which(pvals < .05))

# now we create a matrix of the data for the
# second problem.
fish <- matrix(c(68,89,31,4),2,2)

# we name the rows and columns so that
# it will be easier to keep track of the
# data and make sure we know what is in
# each cell of our table.
row.names(fish) <- c("male","female")
colnames(fish) <- c("present", "absent")

# here we run the chi-square test.
chisq.test(fish)

# we can see that the decision to place
# data in rows or columns has no impact
# on the significance of the statistical test
chisq.test(t(fish))

# here is an example of plotting the data

# this will set the margins on our plot
# remember that these describe margins
# below, left, top, and right of the plot
# respectively
par(mar = c(3, 3, 3, 6))

# this is a package that we can use to
# get colors that are color blind friendly
library(viridis)

barplot(fish,
        col = viridis(2), # specifying colors
        legend=rownames(fish),
        args.legend = list(bty = "n", # supress the box around the legend
                           x = 3.2,   # x position of the legend
                           y = 29))   # y position of the legend

