data<-read.csv("I2.csv", header=T)
names(data)
x<-data[,10:38]
model<-prcomp(x, scale=TRUE)
summary(model)
plot(model)
plot(model$x[,c(1,2)])
color<-as.factor(data$Species)
color<-as.character(data$COLOR)
plot(model$x[,c(1:2)],col=color, pch=16)
text(model$x[,1],model$x[,2],data$Specimen,cex=0.7,pos=4,col="black")
model$x
model$rotation
model$x[,1]
(model$sdev)^2