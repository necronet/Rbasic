# Excercise with K-means 

# This excercise works with the USArrests dataset and it help to visualize how the distribution
# can be easily plotted in R

# Based on: http://www.grroups.com/blog/r-simple-graphs-plots-to-visualize-and-compare-data-distribution

dev.off()
state.names = row.names(USArrests)
barplot(USArrests$Murder, names.arg = state.names, las = 2, ylab = "Murder Rate per 100,000", 
        main = "Murder Rate in the United States in 1973")
hist(USArrests$Rape)

plot(y = USArrests$Murder, x = USArrests$Assault, main = "Murder Rate vs. Assault Rate, US, 1973")
plot(y = USArrests$Rape, x = USArrests$Assault, main = "Rape Rate vs. Assault Rate, US, 1973")
boxplot(USArrests[,c(1,4)], horizontal=TRUE, col= c("red","yellow"),main="Murder and Rape Rate in US")
hist(USArrests[,1], breaks=10,col="purple",main="Murder Rate in US",xlab="Murder Rate")


showHistograms <- function() {
  par(mfrow=c(3,1))
  cnames <- colnames(USArrests)
  Crimes<- USArrests[,-3]
  
  for( i in 1:3) {
    hist(Crimes[,i], xlim=c(0, max(Crimes[,i]+10)), breaks=seq(0, max(Crimes[,i]+5), 5), 
         main=cnames[i], col=i*2,xlab=cnames[i],probability=TRUE)
  }  
}


showHistAndDensity <- function()  {
  dev.off()
  par(mfrow=c(3,1))
  cnames <- colnames(USArrests)
  Crimes<- USArrests[,-3]
  
  for ( i in 1:3) {
    d<-density(Crimes[,i])
    hist(Crimes[,i], xlim=c(0, max(Crimes[,i]+10)), breaks=seq(0, max(Crimes[,i]+5), 5), 
         main=cnames[i], col=i*2,xlab=cnames[i],probability=TRUE)
    #plot(d,main=cnames[i],xlab=paste(cnames[i]," rate in the US",sep=" "), type="n")
    lines(d)
  }
}

showHistograms()
showHistAndDensity()