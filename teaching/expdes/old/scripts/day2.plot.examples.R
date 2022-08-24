# plot 1
# First lets plot some simple count data

# here we create a numeric vector
counts <- c(41, 54, 55)

# assign names to the numeric vector
names(counts) <- c("TAMU","UT","SMU")

# create some confidene intervals for
# the count data - even though most count data
# doesn't actually have uncertainty like this
CIest <- c(.47, 0.79 ,14)
barplot(height = counts,
        ylab = "COVID positive",
        cex.names = .6)
#CI for first one
arrows(.75, counts[1] - CIest[1],
       .75, counts[1] + CIest[1],
       angle = 90,
       code = 3,
       length=.06)

# In reality we would want to make sure that those
# whiskers were well centered so here is an example
# of how I would typically make this barplot for a
# publication.

# this will store the x positions for the bars in
# the plot
xpos <- as.vector(barplot(counts))

# now we make the basic barplot
# you might notice that I am changing the
# limits of the Y axis this is becuase one
# of our datasets SMU had such high values the
# CI bars would go out of the plot range.
barplot(height = counts,
        ylab = "COVID positive",
        cex.names = .6,
        ylim=c(0,70))

# now I will add the CI markers on with a loop
for(i in 1:3){
  arrows(xpos[i], counts[i] - CIest[i],
         xpos[i], counts[i] + CIest[i],
         angle = 90,
         code = 3,
         length=.06)
}


# plot 2

# first lets simulate some continuous data
svl1 <- rnorm(n = 200, mean = 180, sd = 20)
svl2 <- rnorm(n = 100, mean = 250, sd = 30)

# here is a simple histogram
hist(svl1, breaks = 50)

# I am a big fan of density plots so lets make
# one of these. You will notice that I am not
# typing in the limits of the X axis this time
# like I did last time now I am looking at the
# data to pick a good x axis range
plot(density(svl1),
     xlim=c(range(c(svl1,svl2))),
     main = "")
lines(density(svl2), col="red")

# in adding this legend remember what
# happened in class we got slightly different
# values since we generated these from random
# draws from a distribution.
points(300, .02, pch=15, col="black")
points(300, .018, pch=15, col="red")
text(300, .02, "site 1", pos = 4, cex = .5)
text(300, .018, "site 2", pos = 4, cex = .5)

# I really like these density distributions to be
# filled rather than just curves lets look at how
# we can fill in the area under each curve
polygon(density(svl1), col = rgb(0,0,0,.1))
polygon(density(svl2), col = rgb(1,0,0,.1))
# the part you see here "col = rgb(1, 0, 0, .1)"
# this defines the way to fill the area under the
# curve using the function rgb the arguments that
# go to this function are the amount of red, green
# and blue to include in the color. The final argument
# .1 is the alpha level. The easiest way to think of
# this is as the degree of fill .1 equalling a 10% fill.

# In class I showed you a version with bars showing
# the credible interval on these lets look at how
# I could do that. Pay special attention to line 99
plot(density(svl1),
     xlim=c(range(c(svl1,svl2))),
     ylim=c(-.003,.021), # this will give us space
     main = "", xlab="length(cm)")
lines(density(svl2), col="red")
points(300, .02, pch=15, col="black")
points(300, .018, pch=15, col="red")
text(300, .02, "site 1", pos = 4, cex = .5)
text(300, .018, "site 2", pos = 4, cex = .5)
polygon(density(svl1), col = rgb(0,0,0,.1))
polygon(density(svl2), col = rgb(1,0,0,.1))

# now we will use the coda package to get the
# credible intervals.
library(coda)
svl1CI <- HPDinterval(as.mcmc(svl1))
svl2CI <- HPDinterval(as.mcmc(svl2))

# now lets add them to the plot. Note the
# use of lwd (line width) this allows us to
# make these lines a visually appealing width
lines(svl1CI,c(-0.001, -0.001), lwd = 3)
lines(svl2CI,c(-0.002, -0.002), lwd = 3, col = "red")


# HOMEWORK HELP

# here we read in the file
dat <- read.csv("homework2.csv")

# at this point you can really use the
# same approach that we used on the svl values
# above. One thing that might take you a moment
# to figure out is that previously we had two vectors
# now you have a table and the numbers you want to
# plot are in the columns.

# to extract a column out we could do something
# like this
par1 <- dat$par1

# or
par1 <- dat[,2]

# either approach will create the vector par1
# then you could plot just like above.

# EXTRA
# after some of you left to day I promised to
# also show you how to make a stripchart here is an
# example of a stripchart for the svl data

stripchart(list(svl1, svl2),
           main="Python sizes",
           vertical=T,
           ylab="Length (cm)",
           xlab="site",
           method="jitter",
           at=c(.5,1),
           xlim=c(.3,1.2),
           col=rgb(0,0,0,.5),
           pch=16,
           cex=.6)

