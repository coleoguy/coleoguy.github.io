# Heath Blackmon
# coleoguy@gmail.com
# This script explores the frequency of eruptions at the Old Faithful geyser
# 28 Jan 2016

# ok lets write a function that we will need
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# read in our data
OF.data <- read.csv(url("http://coleoguy.github.io/SWC/geyser.csv"))

# lets take a look at our data
head(OF.data)

# it looks like we want the information from column 3
waiting.time <- OF.data[ ,3]

# lets determine the most frequent waiting time
mode(waiting.time)
# that was a weird result lets figure out what went wrong

# we can see what the function mode does
help(mode)

# now we can use our own Mode function
Mode(foo)

# lets look at our data to make sure we aren't missing anything
hist(foo)
# good thing we did it looks like it is multimodal
