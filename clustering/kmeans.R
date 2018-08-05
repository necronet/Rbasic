# A simple implementation of K-means for clustering
require(MASS)
library(ggplot2)

euclideanDist <- function (x,y) {
  rowSums((x-y)^2)
}

show_cluster <- function(points,c_coords,classified){
  with(df, plot(points, col=classified,pch=1))
  points(c_coords,col="red", pch=18)
}

# Using standard R clustering library
df = as.data.frame( cbind(c(x),c(y)) )
k2 <- kmeans(df, centers = 2)  
k2$cluster[k2$cluster==2]="orange"
k2$cluster[k2$cluster==1]="blue"
with(df, plot(df, col=k2$cluster,pch=1))
points(k2$centers,col="red", pch=18)


dev.off()
set.seed(1)
p <- 2
x = mvrnorm(100, c(-2,4), Sigma=diag(p))
y = mvrnorm(100, c(4,2), Sigma=diag(p))
df = as.data.frame( cbind(c(x),c(y)) )

# Step 1. Specify K cluster
k = 2

# Step 2. Randomly select k objects from the dataset as initial clusters
centroids = sample(nrow(df),k)
#df[centroids,]
# Step 3. Assign each observation to the closest centroid
cluster = rep(0,nrow(df))
cluster[cluster==2] <- 3

centroids_points <- rep(unname(unlist(t(df[centroids,]))), nrow(df) )
dim(centroids_points) <- c(length(unlist(df[centroids,])),nrow(df))
centroids_points <- as.data.frame(t(centroids_points))

from <- seq(1,k*p,p)
distances <- matrix(rep(0,k*nrow(df)),ncol=2)

for(i in 1:k) {
  to <- i*p
  distances[,i] <- euclideanDist(df,centroids_points[from[i]:to]) 
}
for(i in 1:k) {
  cluster[which(distances[,i]==apply(distances,1,min))]<-i
}
distances <- as.data.frame(distances)

show_cluster(df,df[centroids,],cluster)

# Step 4. For each cluster k, update the centroid by calculating the new mean value
iter <- 10
prev_centroids <- df[centroids,]
for( i in 1:iter){
  
  centroid_coords <- sapply(1:k, function(i,df,cluster) colMeans(df[cluster==i,]), df, cluster)
  centroids_points <- matrix( rep(as.vector(t(centroids_coords)),each=nrow(df)),nrow=nrow(df))
  
  if(all(prev_centroids == centroid_coords)){
    print(sprintf("Converge point, mean is no longer changing after %d iteration", i))
    break
  }
  for(i in 1:k) {
    to <- i*p
    distances[,i] <- euclideanDist(df,centroids_points[,from[i]:to]) 
  }
  for(i in 1:k) {
    cluster[which(distances[,i]==apply(distances,1,min))]<-i
  }
  prev_centroids <- centroid_coords
  
}
show_cluster(df,centroids_coords,cluster)
