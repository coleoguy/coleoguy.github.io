
#Heath Blackmon 5 January 2013
#my code for exercise one for R seminar

mydata <- read.csv("finch.csv")            #  read in the data
myvec <- mydata[,3]                        #  pull out the values of interest
myvec <- myvec/.035                        #  transform into SI units
sum(myvec)/length(myvec)                   #  calculate the mean w/o func
mean(myvec)                                #  and now with the func
sqrt((sum((myvec-mean(myvec))^2))/(length(myvec)-1)) 
                                           #  sd without sd function
sd(myvec)                                  #  and now with the sd func
myvec <- sort(myvec)                       #  sort numerically prior to calculating median
mean(c(myvec[length(myvec)/2],myvec[length(myvec)/2+1]))    
                                           #  median w/o function
median(myvec)                              #  now with the median func
sd(myvec)/sqrt(length(myvec))              #  std error of the mean

myvec[15] <- NA                            #  add a missing value
mean(myvec)                                #  just to show the problem
help(mean)                                 #  by calling this we see that we can add another 
                                           #  argument in the function: "na.rm = T"
mean(myvec, na.rm=T)                       #  so here is the "normal way"