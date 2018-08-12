# Based on João Neto example
# Ref: http://www.di.fc.ul.pt/~jpn/r/EM/EM.html#the-meta-algorithm

## An example of using EM algorithm with random generated Linear models
set.seed(102)

# It will return a two column matrix with generated values from a random
# linear model, predefined slop and intercept
random_lm <- function(slope,intercept, noise=0.35, N=40, upper_x=501) {
  xs <- sample(seq(-5,10,len=upper_x), N)
  ys <- intercept + slope*xs + rnorm(length(xs),0,noise)
  cbind(xs,ys)
}
mydata <- rbind( random_lm(-1.3,1.5,noise=0.85,N=100, ), random_lm(1.3,-0.5, N=75, noise=1.2) )
png("em-0.png", width=900, height=570, units="px", pointsize=18)
plot(mydata, pch=19, xlab="X", ylab="Y")
title("EM Maximization for Linear models initial")

init_params <- function() {
  i1 <<- 2*runif(1)
  s1 <<- 2*runif(1)
  i2 <<- 2*runif(1)
  s2 <<- 2*runif(1)
  c(i1,s1,i2,s2)
}

# It calculates probabilities of all points residuals, likelihood of belonging to Ci
e.step <- function(mydata, params, sigma=0.75) {
  e1 <- exp( (-abs(params[1] + params[2]*mydata[,1] - mydata[,2])^2)/(sigma^2) )
  e2 <- exp( (-abs(params[3] + params[4]*mydata[,1] - mydata[,2])^2)/(sigma^2) )
  cbind(e1/(e1+e2), e2/(e1+e2))
}

wls <- function(X,Y,W) {
  solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% Y
}

m.step <- function(mydata, ws) {
  X <- cbind(rep(1, nrow(mydata)), mydata[,1])
  Y <- as.matrix(mydata[,2], ncol=1)
  p_1 <- wls(X,Y,diag(ws[,1]))
  p_2 <- wls(X,Y,diag(ws[,2]))
  
  c(p_1, p_2)
}


em.2lines <- function(mydata, tol=1e-2, max.step=1e3) {
  step <- 0
  
  s1 <- i1 <- s2 <- i2 <- 0 # model parameters for slope and intersect
  params <- init_params()
  
  repeat {
    
    ws         <- e.step(mydata, params)
    old.params <- params
    params     <- m.step(mydata, ws)
    
    class<-apply(ws, 1, function(v) if (v[1]>v[2]) 1 else 2)
    png(paste("em-",step,".png", sep=""), width=900, height=570, units="px", pointsize=18)
    
    plot(mydata, pch=19, col=class, xlab="X", ylab="Y")
    title(paste("EM Maximization for Linear models #",step))
    abline(a=params[1], b=params[2], col=1, lty=2) # draw 1st model with found parameters
    abline(a=params[3], b=params[4], col=2, lty=2) # draw 2nd model with found parameters
    
    if (norm(as.matrix(old.params-params), type="F") < tol) # convergence achieved
      break
    
    step <- step +1
    if (step > max.step)
      break
    
    dev.off()
  } 
  
  
}
e.step(mydata, init_params())
report <- em.2lines(mydata)




