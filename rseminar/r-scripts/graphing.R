require(TeachingDemos)

#get data and down sample
data.all <- read.table("combined.log", header=T, row.names="Iteration")
data<-data.all[,c(1:6,15)]
s.size<-1000  #how many points do you want to sample
rows <- sample(1:50000, s.size)
s.data<-data.frame()
s.data<-data[rows,]
est.means<-colMeans(s.data[,1:7])

#HERE WE CAN GO AHEAD AND SET UP A PLOT WINDOW
par(mfcol=c(1,1))

#set up all the collor vectors i am going to use
colors<-vector()
colors[1:(s.size)]<-"red"
colors[(s.size+1):(2*s.size)]<-"red"
colors[((2*s.size)+1):(3*s.size)]<-"red"
colors[((3*s.size)+1):(4*s.size)]<-"red"
colors[((4*s.size)+1):(5*s.size)]<-"red"
colors[((5*s.size)+1):(6*s.size)]<-"red"
colors[((6*s.size)+1):(7*s.size)]<-"blue"
colors2<-unique(colors)
colr<-vector()
colr[1:6]<-"red"; colr[7]<-"blue"
sepcol <- c("blue","blue","blue","blue","blue","blue","red")


#HERE LETS JUST NAME THESE TRANSITIONS and GROUPS
names<-c("XO->XY","XO->Xy+","XY->XO","XY->Xy+","Xy+->XO","Xy+->XY","XO<->XY")
taxa <- c("Polyphga","Polyphga","Polyphga","Polyphga","Polyphga","Polyphga","Adephaga")

#THIS VERSION OF THE JITTER FUNCTION KEEPS A BAR
create a jittered variable for spreading out the estimates
spreads<-data.frame()
spreads[1:s.size,1]<-1
spreads[,1]<-as.numeric(lapply(spreads[,1],jitter, factor=18))
for(i in 1:20) spreads[,i+1]<-spreads[,i]+1



#try and plot this with points and using jitters as described above
plot(
  c(s.data[,1],s.data[,2],s.data[,3],s.data[,4],s.data[,5],s.data[,6],s.data[,7])~
  c(spreads[,1],spreads[,2],spreads[,3],spreads[,4],spreads[,5],spreads[,6],spreads[,7]),
  col=colors,pch=20,cex=.1,xlab="Transition",ylab="Probability of Transition per Million Years", xaxt='n',bg="gray", main="Posterior Distribution of Transition Rates")

#calculate the highest posterior density for the data of interest
hpd.bars<-matrix(,7,2)
for(i in 1:7)hpd.bars[i,]<-emp.hpd(s.data[,i])
for(i in 1:7)arrows(i, hpd.bars[i,1], i, hpd.bars[i,2], col="black", length = 0.1, angle = 90,code = 3,lwd=2)
text(1:7,(.0098), names[1:7],cex=.8,col=colr)
for(i in 1:7)points(i, est.means[i],pch=21,col="black",cex=1.5,lwd=2)
for(i in 1:7)points(i, est.means[i],pch=20,col="gold",cex=1.4,lwd=2)







#austin slides run everything above this first then:


plot(
  c(s.data[,1],s.data[,2],s.data[,3],s.data[,4],s.data[,5],s.data[,6])~
  c(spreads[,1],spreads[,2],spreads[,3],spreads[,4],spreads[,5],spreads[,6]),
  col=colors,
    pch=20,
    cex=.1,xlab="Transition",
    ylab="Probability of Transition per Million Years",
    ylim=c(0,.01),
    xaxt='n',
    bg="gray",
    main="Posterior Distribution of Transition Rates")

#calculate the highest posterior density for the data of interest
hpd.bars<-matrix(,7,2)
for(i in 1:6)hpd.bars[i,]<-emp.hpd(s.data[,i])
for(i in 1:6)arrows(i, hpd.bars[i,1], i, hpd.bars[i,2], col="black", length = 0.1, angle = 90,code = 3,lwd=2)
text(1:6,(.0098), names[1:6],cex=.8,col=colr)
for(i in 1:6)points(i, est.means[i],pch=21,col="black",cex=1.5,lwd=2)
for(i in 1:6)points(i, est.means[i],pch=20,col="gold",cex=1.4,lwd=2)

plot(s.data[,7]~spreads[,7],
  col="blue",
     ylim=c(0,.01),
     pch=20,
  cex=.1,xlab="Transition",
  ylab="Probability of Transition per Million Years",
  xaxt='n')

#calculate the highest posterior density for the data of interest
hpd.bars<-matrix(,7,2)
hpd.bars[7,]<-emp.hpd(s.data[,7])
arrows(7, hpd.bars[7,1], 7, hpd.bars[7,2], col="black", length = 0.1, angle = 90,code = 3,lwd=2)
text(7,(.0098), names[7],cex=.8,col="blue")
points(7, est.means[7],pch=21,col="black",cex=1.5,lwd=2)
points(7, est.means[7],pch=20,col="gold",cex=1.4,lwd=2)
















#Here is a real violin plot without the points and using the full mcmc

par(mfcol=c(1,1))

library(vioplot)
vioplot(data[,1],data[,2],data[,3],data[,4],data[,5],data[,6],data[,7], ylim=c(-0.0004,.011),col="lightblue", names=c("","","","","","",""),drawRect=F)
for(i in 1:7)arrows(i, hpd.bars[i,1], i, hpd.bars[i,2], col=sepcol[i], length = 0.1, angle = 90,code = 3,lwd=3)
#for(i in 1:7)points(i, est.means[i],pch=21,col=sepcol[i],cex=1.5,lwd=2)
for(i in 1:7)points(i, est.means[i],pch=20,col=sepcol[i],cex=1.4,lwd=2)
text(1:7,(-0.0003), names,cex=.6,col=sepcol)
text(1:7,(-0.0006), taxa,cex=.7,col=sepcol)

#BOX PLOT OF DATA
boxplot(s.data[,1:7],notch=T, names)

