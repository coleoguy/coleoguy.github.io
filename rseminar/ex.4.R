#  10 Feb 2013 - Comparing a BM and OU model
#  R Seminar Meeting 4

require(geiger)

ade.trees <- read.nexus("tree2.nex")                       #This reads in the trees
data <- read.csv("chromnum.csv")                           #This reads in the chromosome numbers
chrom.num<-data[,3]                                        #Extract the column with the chromosome numbers
names(chrom.num)<-data$name                                #assign the names to the elements in the vector

ade.bm <- fitContinuous(ade.trees, chrom.num, model="BM")  #fit the BM model
ade.ou <-fitContinuous(ade.trees, chrom.num, model="OU")   #fit the OU model
ade.bm.v.ou<-2*(ade.ou$Trait1$lnl-ade.bm$Trait1$lnl)       #calculate the LR
ade<-pchisq(ade.bm.v.ou, 1, lower.tail=F)                  #calculate the P value

#sigma^2 is beta in fit continous
#lets find Z bar
C.ade <- vcv.phylo(ade.trees)                              #convert our tree to a variance covariance matrix
m.ade <- match(rownames(C.ade),names(chrom.num))           #create a vector with the indexes for the elements we want to use
x.ade <- chrom.num[m.ade]                                  #subset based on the vector just created above
geiger:::phylogMean(C.ade, x.ade)                          #use the internal geiger function to calculate the value of Theta

require(phytools)                                       #phytools can be hard to install on some systems 
                                                        #
taxa.ontree<-ade.trees$tip.label                        #create a vector of tip names
data.ontree<-data[names(chrom.num) %in% taxa.ontree,]   #this creates a data set of only that data that is also on the tree
datav<-data.ontree[,3]                                  #this pulls off the data of interest
names(datav)<-data.ontree[,2]                           #this assigns tip names for the elements of the vector above
contMap(ade.trees,datav,fsize=0,outline=F)              #this is the plot that was in the worksheet


#LETS TRY A QUICK SIMULATION OF THE TWO MODELS

x <- numeric(100)

     sim.ou.better <- function(alpha,theta,start){
     x[1] <- start                                 #this sets the initial value for the sim
     for (i in 1:99){                              #this makes it last 100 generations
       ((theta-x[i])*alpha)->foo                   #this will be our correction term   
       x[i+1] <- x[i] +foo + rnorm(1)              #this assigns the start value for the next generation
     }
     x # return the value of x
     }

X <- replicate(10,sim.ou.better(0,1,10))           #alpha=0 theta=1 start=10 BM model mean should=10
y1 <- range(X)
X2 <- replicate(10,sim.ou.better(.01,5,10))        #alpha=0.01 theta=5 start=10 BM model mean should=5
X3 <- replicate(10,sim.ou.better(.1,5,10))         #alpha=0.1 theta=5 start=10 BM model mean should=5
X4 <- replicate(10,sim.ou.better(1,5,10))          #alpha=1 theta=5 start=10 BM model mean should=5
par(mfcol=c(2,2))
matplot(X, ylim = y1, type ="l", col=rainbow(10),lty=1,lwd=2,main="Brownian\nOU alpha=0")   #rainbow is handy when you want multiple colors but you 
                                                                                            #dont care what they are
matplot(X2, ylim = y1, type ="l", col=rainbow(10),lty=1,lwd=2,main="OU alpha=.01")
matplot(X3, ylim = y1, type ="l", col=rainbow(10),lty=1,lwd=2,main="OU alpha=.1")
matplot(X4, ylim = y1, type ="l", col=rainbow(10),lty=1,lwd=2,main="OU alpha=1")



