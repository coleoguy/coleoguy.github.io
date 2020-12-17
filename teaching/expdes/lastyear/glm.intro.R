# creating matrix 
dogs <- matrix(NA, 100, 4)

# providing names for the columns
colnames(dogs) <- c("rspeed", "breed",
                    "height", "sex")

# converting to dataframe
dogs <- as.data.frame(dogs)

# randomly assigning dog breeds to each row
dogs$breed <- sample(c("BH", "GH", "RR", "GR"),
                     size = 100, replace = T)

# randomly assigning sexes to each row
dogs$sex <- sample(c("female","male"), 
                   size = 100, replace = T)

# drawing random numbers from a normal distribution
dogs$height <- round(rnorm(mean = 33, sd = 11, 
                           n = 100), 
                           digits = 1)
# choosing effect sizes for 3 variabls
bheight <- .87
bsex <- - 3
bbreed <- c(0, 6, 3.5, 4.5)

# assigning a name to each breed effect value
names(bbreed) <- c("BH", "GH", "GR", "RR")

# y intercept base value grand mean
mu <- 2

# populating our dataframe running speeds
for(i in 1:100){
  
  # building the expected value (mean + height effect)
  expected <- mu + bheight * dogs$height[i]
  
  # adjust current expected value for sex
  if(dogs$sex[i] == "male"){
    expected <- expected + bsex
  } 
  
  # determine position of current breed effect
  hitbreed <- which(names(bbreed) == dogs$breed[i])
  
  # adding in current breed effect to expected
  expected <- expected + bbreed[hitbreed]
  
  # getting observed running speeds based on expected values
  dogs$rspeed[i] <- rnorm(mean = expected, 
                          sd = .1 * expected, n = 1) 
}

# fit the basic general linear model
fit <- glm(dogs$rspeed ~ dogs$breed +
             dogs$height + dogs$sex)
# look at the result
summary(fit)

# its all the same thing
summary(glm(dogs$rspeed~dogs$sex))
summary(aov(lm(dogs$rspeed~dogs$sex)))

# get vector to use as arguments to pch 
sex.shapes <- as.numeric(
              as.factor(dogs$sex))+14

# get vector to choose color values
breed.colors <- as.numeric(
                as.factor(dogs$breed))

# load the viridis package
library(viridis)

# assign colors (3 different palletes)
vcols <- viridis(4)[breed.colors]
rcols <- rainbow(4)[breed.colors]
cbcols <- c("#e41a1c", "#377eb8",
            "#4daf4a", "#984ea3")[breed.colors]

# make a plot that doesn't suck
plot(x = dogs$height, y = dogs$rspeed,
     pch = sex.shapes, cex = .6, col = cbcols,
     xlab = "height(cm)", ylab = "running speed (units)")

# add a line showing the slope of the regression 
# on running speed
abline(glm(dogs$rspeed ~ dogs$height), col = "darkgray",
       lty = 2)





