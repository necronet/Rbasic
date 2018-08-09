# Based on João Neto example
# Ref: http://www.di.fc.ul.pt/~jpn/r/EM/EM.html#the-meta-algorithm

## An example of using EM algorithm with random generated Linear models
set.seed(12)

# It will return a two column matrix with generated values from a random
# linear model, predefined slop and intercept
random_lm <- function(slope,intercept, noise=0.15, N=40, upper_x=201) {
  xs <- sample(seq(-2,2,len=upper_x), N)
  ys <- intercept + slope*xs + rnorm(length(xs),0,noise)
  cbind(xs,ys)
}
mydata <- rbind( random_lm(-0.3,1.5,noise=0.15), random_lm(1.6,-0.4, noise=0.2) )
plot(mydata, pch=19, xlab="X", ylab="Y")


i1 <- s1 <- i2 <- s2 <- 0 # model parameters for slope and intersect
init_params <- function() {
  i1 <<- 2*runif(1)
  s1 <<- 2*runif(1)
  i2 <<- 2*runif(1)
  s2 <<- 2*runif(1)
  c(i1,s1,i2,s2)
}

params <- init_params()
