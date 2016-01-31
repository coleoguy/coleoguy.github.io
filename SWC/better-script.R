# Heath Blackmon
# coleoguy@gmail.com
# This script explores the frequency of eruptions at the Old Faithful geyser
# 28 Jan 2016

# ok lets write a function to return the mode
Mode <- function(x) {
  ux <- unique(x) # finds the unique values of x
  ux[which.max(tabulate(match(x, ux)))] # counts the unique occurances in x
}

# get our data on old faithful
data("faithful")

# lets take a look at our data
head(faithful)

# it looks like we want the waiting times from column 3
waiting.time <- faithful[ ,2]

# lets determine the most frequent waiting time
mode(waiting.time)
# that was a weird result lets figure out what went wrong

# we can see what the function mode does
help(mode)

# now we can use our own Mode function
Mode(waiting.time)

# lets look at our data to make sure we aren't missing anything
hist(waiting.time)
# good thing we did it looks like it is multimodal
