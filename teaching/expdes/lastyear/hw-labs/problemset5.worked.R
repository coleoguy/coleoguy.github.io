# problem set 5 my approach

# problem 1
horns <- read.csv("horns.csv")
t.test(x = horns[1:25,1], 
       y = horns[26:50,1], alternative = "greater")
t.test(x = horns[1:25,1], 
       y = horns[26:50,1])

# I used a one sided two sample t test comparing the control and large 
# horn strains and found that these were significantly different from 
# each other. The 95% confidence interval for the difference in these is 
# 0.012 to 0.329. From this I conclude that soft-selection on horn size 
# leads to an increase in horn size. The p-value associated with this test 
# was 0.0174.



# problem 2
grasshopper <- read.csv("grasshopper.csv")

# initial vs postcrush
t.test(grasshopper$precrush,grasshopper$postcrush, paired = T)
t.test(grasshopper$postcrush, grasshopper$recovered, paired = T)
t.test(grasshopper$recovered, grasshopper$recrush, paired = T)


t.test(grasshopper$precrush,
       grasshopper$postcrush, 
       paired = T,
       alternative="less")
t.test(grasshopper$postcrush,
       grasshopper$precrush, 
       paired = T,
       alternative="greater")



library(beeswarm)
beeswarm(grasshopper, col="darkgreen", pch=16, ylab="range of motion")

# Pre and post crush range of motion was compared using a paired two 
# sample t test. For the initial crush my p-value was <0.001 suggesting 
# that the researcher was successful in crushing the nerve serving this 
# leg. Postcrush and recovered range of motion was compared using a paired two 
# sample t test. For this comparison my p-value was <0.001 suggesting that 
# these grasshoppers recovered movement. Recovered and recrush range of 
# motion was compared using the same test. For this comparison my p-value 
# was <0.001 suggesting that range of motion was recovered by repair of 
# this nerve rather than sparing of some nerve that took over control of
# the leg after the initial injury. When I visually explored the data I 
# found that four samples from each surgery have range of motions that 
# suggest that a small percentage of crush surgerys actually failed and 
# did not lead to a loss of function.


