require(TeachingDemos)
require(plotrix)

#get data and down sample
data.all <- read.table("combined.log", header=T, row.names="Iteration")
data<-data.all[,c(1:8,16,17)]
s.size<-10000  #how many points do you want to sample
rows <- sample(1:50000, s.size)
s.data<-data.frame()
s.data<-data[rows,]
est.means<-colMeans(s.data[,1:10])

colnames(s.data)<-c("XO->XY","XO->Xy+","XY->XO","XY->Xy+","Xy+->XO","Xy+->XY","A.XO->XY","A.XY->XO","prob.tran.ade","prob.tran.pol")


#calculate the highest posterior density for the data of interest
hpd.bars<-matrix(,10,2)
for(i in 1:10)hpd.bars[i,]<-emp.hpd(s.data[,i])
rownames(hpd.bars)<-colnames(s.data)

#NEW PLOTS
pol.y.gain<-s.data[,1]+s.data[,2]
pol.y.loss<-s.data[,3]+s.data[,5]
pol.yp.loss<-s.data[,5]
pol.y.to.yp<-s.data[,4]
ade.y.gain<-s.data[,7]
ade.y.loss<-s.data[,8]
t.prob.ade<-s.data[,9]
t.prob.poly<-s.data[,10]


#FIRST HERE IS A BASIC PLOT OF Y CHROMOSOME GAIN AND LOSS NO Y+ STUFF
plot(density(pol.y.loss),
     col=colors()[32],
     main="Sex Chromosome\nTransition Rates",
     ylab="Marginal Density",
     xlab="Estimated Transitions per branch per million years",
     lwd=4,ylim=c(0,1200),
     xlim=c(0,.011),
     cex.main=.7,
     cex.lab=.7,
     new=F)
lines(density(pol.y.gain),col=colors()[33],lwd=3,)
lines(density(ade.y.gain),col=colors()[123],lwd=3,)
lines(density(ade.y.loss),col=colors()[132],lwd=3,)

foo<-c("Polyphaga","XY to XO","XO to XY","",
       "Adephaga","XY to XO","XO to XY")
legend(.0087,1200,foo,y.intersp=1.5,pch=20,bty="n",pt.cex=1,cex=.5,col=c("white",colors()[32],colors()[33],"white","white",colors()[132],colors()[123]))
polygon(density(pol.y.loss),col=colors()[32],density=180,lwd=.1)
polygon(density(pol.y.gain),col=colors()[33],density=180,lwd=.1,angle=-45)
polygon(density(ade.y.gain),col=colors()[123],density=180,lwd=.1)
polygon(density(ade.y.loss),col=colors()[132],density=180,lwd=.1,angle=-45)




#HERE IT IS WITH Y+ GAIN AND LOSS
plot(density(pol.y.loss),
     col=colors()[32],
     main="Sex Chromosome Transition Rates",
     ylab="Marginal Density",
     xlab="Estimated Transitions per branch per million years",
     cex.main=.7,
     cex.lab=.7,
     cex.axis=.6,
     lwd=3,ylim=c(0,1200),
     xlim=c(0,.011))
axis.break(2,1057,breakcol="black",style="slash")
lines(density(pol.y.gain),col=colors()[33],lwd=3,)
lines(density(ade.y.gain),col=colors()[123],lwd=3,)
lines(density(ade.y.loss),col=colors()[132],lwd=3,)
#adjust yp to fit actual peak occurs at 2600
foobar<-density(pol.yp.loss)
foobar[[2]]<-foobar[[2]]*(1200/max(foobar[[2]]))
yp.fixed<-foobar
lines(yp.fixed[1:2],col=colors()[258],lwd=3,)
lines(density(pol.y.to.yp),col=colors()[414],lwd=3,)

foo<-c("Polyphaga","XY to XO","XO to XY","XY+ to XO","XY to XY+","","Adephaga","XY to XO","XO to XY")
legend(.0087,1200,foo,y.intersp=1.5,pch=20,bty="n",pt.cex=1,cex=.5,col=c("white",colors()[32],colors()[33],colors()[258],colors()[414],"white","white",colors()[132],colors()[123]))
for(i in 1:100)mtext("1200",2,1,at=1200,col="white",font=2,cex=.6)
mtext("2600",2,1,at=1200,cex=.6)

#polygon(density(pol.y.loss),col=colors()[32],density=180,lwd=.1)
#polygon(density(pol.y.gain),col=colors()[33],density=180,lwd=.1,angle=-45)
#polygon(density(ade.y.gain),col=colors()[123],density=180,lwd=.1)
#polygon(density(ade.y.loss),col=colors()[132],density=180,lwd=.1,angle=-45)
#polygon(yp.fixed[1:2],col=colors()[258],density=180,lwd=.1,angle=-45)
#polygon(density(pol.y.to.yp),col=colors()[414],density=180,lwd=.1,angle=-45)




#LETS MAKE A PLOT OF JUST THE RAW CHANCE OF A TRANSIITON HAPPENING IN BOTH SUBORDERS


plot(density(t.prob.ade),
     col=colors()[32],
     main="Probability of a Transition in Sex Chromosome System",
     ylab="Marginal Density",
     xlab="Estimated Transitions per branch per million years",
     lwd=4,ylim=c(0,370),
     xlim=c(0,.022))
lines(density(t.prob.poly),col=colors()[123],lwd=4,)
polygon(density(t.prob.ade),col=colors()[32],density=180,lwd=.1)
polygon(density(t.prob.poly),col=colors()[123],density=180,lwd=.1)




#create a jittered variable for spreading out the estimates
spreads<-data.frame()
spreads[1:s.size,1]<-1
spreads[,1]<-as.numeric(lapply(spreads[,1],jitter, factor=18))
for(i in 1:2) spreads[,i+1]<-spreads[,i]+1

plot(t.prob.poly~spreads[,1],col=colors()[32],xlim=c(.5,2.5),ylim=c(.002,.02),pch=20,cex=.1,xlab="Transition",ylab="Probability of Transition per Million Years", xaxt='n',bg="gray", main="Posterior Distribution of Transition Rates")
points(t.prob.ade~spreads[,2],col=colors()[125],pch=20,cex=.1)
for(i in 1:2)arrows(i, hpd.bars[11-i,1], i, hpd.bars[11-i,2], col="black", length = 0.1, angle = 90,code = 3,lwd=2)
text(1:2,(.02), c("Polyphaga","Adephaga"),cex=.8,col="black")
for(i in 1:2)points(i, est.means[11-i],pch=21,col="black",cex=1.5,lwd=2)
for(i in 2:1)points(i, est.means[11-i],pch=20,col="gold",cex=1.4,lwd=2)