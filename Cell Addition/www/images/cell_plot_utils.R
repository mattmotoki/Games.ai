library(png)
library(aws)

# plotting parameters
n_pnts <- 100
cellgreen <- c(34/255,250/255,34/255)
cellred <- c(230/255,142/255,54/255)
cellfuscia <- c(230/255,54/255,230/255)
cellblue <- c(34/255,142/255,250/255)

#------------------
# single cell plotting functions

# square
square_cell <- function(r, n_pnts) {
  R <- rep(r, n_pnts)
  theta <- seq(0, 2*pi, length.out = 4*n_pnts)
  
  x <- r*cos(theta) + c(1-R, R, R, 1-R) - 0.5
  y <- r*sin(theta) + c(1-R, 1-R, R, R) - 0.5
  cbind(x, y)
}


# triangular
triangular_cell <- function(r, r2, n_pnts) {
  R <- rep(r, n_pnts)
  R2 <- rep(r2, n_pnts)
  
  theta <- c(seq(0, pi/2, length.out = n_pnts), 
             seq(pi/2, 5*pi/4, length.out = n_pnts),
             seq(5*pi/4, 2*pi, length.out = n_pnts))
  
  
  x <- c(R, R2, R2)*cos(theta) + c(1-R, R2*(1+sqrt(2)),  1-R2) - 0.5
  y <- c(R, R2, R2)*sin(theta) + c(1-R, 1-R2,  R2*(1+sqrt(2))) - 0.5
  cbind(x, y)
}


# side triangular
side_triangular_cell <- function(r, r2, n_pnts) {
  R <- rep(r, n_pnts)
  R2 <- rep(r2, n_pnts)
  theta <- c(seq(0, 3*pi/4, length.out = n_pnts),
             seq(3*pi/4, 5*pi/4, length.out = n_pnts),
             seq(5*pi/4, 2*pi, length.out = n_pnts))
  x <- c(R, R2, R)*cos(theta) + c(1-R, 0.5+sqrt(2)*R2, 1-R) - 0.5
  y <- c(R, R2, R)*sin(theta) + c(1-(1+sqrt(2))*R, rep(0.5, n_pnts), (1+sqrt(2))*R) - 0.5
  cbind(x, y)
}


# quadrilateral
quad_cell <- function(r, r2, n_pnts) {
  R <- rep(r, n_pnts)
  R2 <- rep(r2, n_pnts)
  
  theta <- c(seq(0, pi/2, length.out = n_pnts), 
             seq(pi/2, pi, length.out = n_pnts),
             seq(pi, 5*pi/4, length.out = n_pnts),
             seq(5*pi/4, 2*pi, length.out = n_pnts))
  
  x <- c(R, R, R, R2)*cos(theta) + c(1-R, 0.5+R, 0.5+R, 1-R2) - 0.5
  y <- c(R, R ,R, R2)*sin(theta) + c(1-R, 1-R, 0.5 + R*(sqrt(2)-1), R2*(1+sqrt(2))) - 0.5
  cbind(x, y)
}




#------------------
# post single cell plotting functions

# center of mass calculation
com_calc <- function(x, y) {
  # plot shape
  png('temp.png', width = 1000, height = 1000)
  par(mar=c(0,0,0,0), bg="NA")
  plot(1, type="n", asp=1, axes = FALSE,
       yaxs="i", xaxs="i", xlab = "", ylab = "",
       xlim = c(0, 1), ylim = c(0, 1)
  )
  polygon(x, y, col=rgb(0,0,0), border=NA)
  dev.off()
  
  img <- 1*(readPNG("temp.png")[, , 4]>0.5)
  img <- img/sum(img)
  
  com_x <- sum(img %*% seq(0, 1, length=dim(img)[1]))
  com_y <- 1-sum(t(img) %*% seq(0, 1, length=dim(img)[1]))
  
  print(c(com_x, com_y))
  c(com_x, com_y)
  
}

# plot a single cell with shadow and dimple
plot_cell <- function(x, y, color) {
  
  # start with all black cell
  polygon(x, y, col="black", border=NA)
  
  # get center of mass
  com <- com_calc(x, y)
  
  # add shadow
  n_layers <- 100
  shink <- seq(1, 0,length=n_layers)
  alpha <- seq(0.1, 1, length=n_layers)
  for (k in 1:n_layers) {
    polygon(shink[k]*(x-com[1])+com[1], shink[k]*(y-com[2])+com[2],
            col=rgb(color[1], color[2], color[3], alpha[k]),
            border=NA)
  }
  
  # add dimple
  n_layers <- 25
  shink <- seq(0.25, 0.85, length=n_layers)^2
  alpha <- seq(0.01, 0.05, length=n_layers)
  color <- 0.5*color
  for (k in 1:n_layers) {
    polygon(shink[k]*(x-com[1])+com[1], shink[k]*(y-com[2])+com[2],
            col=rgb(color[1], color[2], color[3], alpha[k]),
            border=NA)
  }
}

# create a blank plot
blank_plot <- function() {
  par(mar=c(0,0,0,0), bg=NA)
  plot(1, type="n", asp=1, axes=FALSE, 
       yaxs="i", xaxs="i", xlab = "", ylab = "",
       xlim = c(-0.002, 1.002), ylim = c(-0.002, 1.002)
  )
}




# ### Smoothing
# The final step is to smooth out the values between the edges of the polygons.  This is done in R using smoothing spines.  
# 
# library(data.table)
# library(aws)
# 
# smooth_cell <- function(x, y) {
#   png('temp.png', width = 800, height = 800)
#   blank_plot()
#   polygon(c(0,0,1,1), c(0,1,1,0),col="black") # add black background
#   plot_cell(x, y, cellgreen)
#   dev.off()
#   
#   
#   # smooth cell
#   img <- readPNG("temp.png")
#   border_inds <- which(img[, , k]==0)
#   for (k in 1:3) {
#     # smooth entire matrix
#     # temp <- kernsm(img[, ,k], h=10, kern="Triangle")@yhat
#     # temp <- kernsm(img[, ,k], h=10, kern="Epanechnicov")@yhat
#     
#     temp <- kernsm(img[, , k], h=10, kern="Gaussian")@yhat
#     temp[temp<0] <- 0
#     temp[temp>1] <- 1
#     temp[border_inds] <- 1
#     img[, , k] <- temp
#   }
#   
#   img
# }
# 
# graphics.off()
# img <- smooth_cell(x, y)
# blank_plot()
# rasterImage(img, 0, 0, 1, 1)
# # abline(v=c(0, 1), h=c(0, 1))  
# 
# 
# blank_plot()
# plot_cell(x, y, cellgreen)
# # abline(v=c(0, 1), h=c(0, 1))


