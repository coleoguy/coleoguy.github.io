
#  Heath Blackmon 15 January 2013
#  my code for exercise two for R seminar
#  this code will create a function and produce some graphs

mydata <- read.csv("div.csv")                             #  read in the data
str(mydata)
mydata <- mydata[,3:6]                                    #  extract the column of interest

#  Lets use this data to explore some basic commands used when plotting
#  plot, hist, density, boxplot, lines, points, and text
#  we will also do our first very simple statistical test

#  FIRST FOR PLOTTING
plot(mydata[,1:3])
hist(mydata[,1])
boxplot(mydata[,1],mydata[,2])


#  our goal here is to plot the divergences of the autosomal and sex chromosome loci
#  in such a way that we can see any obvious differences  you could do this in a variety
#  of ways i will use boxplots in this example.  With a little work you could use hist, 
#  plot, or boxplot and produce equally interesting graphs.

par(mfcol=c(1,1))
attach(mydata)            #This allows us to call data by the column name see line 43,44, and 45

boxplot(mydata[Location=="Sex Chromosome",1], mydata[Location=="Autosome",1], 
        mydata[Location=="Sex Chromosome",3],mydata[Location=="Autosome",3],
        mydata[Location=="Sex Chromosome",2],mydata[Location=="Autosome",2])




#  THEY LOOK DIFFERENT, ARE THEY?
#  we can do a simple t test on each of these cases and see whether the two classes of loci really are 
#  statistically different.  To do this we will just use the function t.test 
conf <- t.test(mydata[,1] ~ Location)     #col 1 has data for one species while location is the factor variable
free <- t.test(mydata[,2] ~ Location)     #col 2 has data for one species while location is the factor variable
made <- t.test(mydata[,3] ~ Location)     #col 3 has data for one species while location is the factor variable




boxplot(mydata[Location=="Sex Chromosome",1], mydata[Location=="Autosome",1], 
        mydata[Location=="Sex Chromosome",3],mydata[Location=="Autosome",3],
        mydata[Location=="Sex Chromosome",2],mydata[Location=="Autosome",2],
        horizontal=T,
        xlab="Genetic Divergence",
        col=c("red","blue"),
        main="Comparison of Sex-linked and Autosomal Loci",
        ylim=c(-.1,.3),
        xlim=c(.5,7.3)
)

text(-.05,1.5,"T. confusum")
text(-.05,3.5,"T. madens")
text(-.05,5.5,"T. freemani")
points(0.01,7,pch=15,col="blue",cex=3)
points(0.11,7,pch=15,col="red",cex=3)
text(.02,pos=4,7,"Autosome")
text(.12,pos=4,7,"Sex Chromosome")
text(.28,6.5,"Welch's T-test\n P-value",cex=.8)


#  lets go ahead and add those results to our graph
text(.28,1.5,signif(conf$p.value, digits=3),cex=.8)
text(.28,3.5,signif(made$p.value, digits=3),cex=.8)
text(.28,5.5,signif(free$p.value, digits=3),cex=.8)
