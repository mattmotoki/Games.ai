





#----------------
# single
r <- 0.2
n_points <- 100
R <- rep(r, n_points/4)
theta <- seq(0, 2*pi, length.out = n_points)
square_x <- r*cos(theta) + c(1-R, R, R, 1-R)
square_y <- r*sin(theta) + c(1-R, 1-R, R, R)



plot_cell <- function(x, y, color, add_grid = FALSE) {
  # shadow parameters
  n_layers <- 50
  shink <- sqrt(seq(1, 0,length=n_layers))
  alpha <- seq(0.1, 1, length=n_layers)

  # scale to unit length
  d <- max(max(x) - min(x), max(y) - min(y))
  x <- x/d
  y <- y/d
  
  # center outline 
  x <- x - mean(x)
  y <- y - mean(y)

  # plot shape
  par(mar=c(0,0,0,0), bg="NA")
  plot(1, type="n", asp=1, axes = FALSE,
       yaxs="i", xaxs="i", xlab = "", ylab = "",
       xlim = c(-0.5, 0.5), ylim = c(-0.5, 0.5)
  )
  polygon(x, y, col=rgb(0,0,0), border=NA)
  
  # add shadow
  for (k in 1:n_layers) {
    polygon(shink[k]*x, shink[k]*y,
            col=rgb(color[1], color[2], color[3], alpha[k]),
            border=NA)
  }
  
  # add grid
  if (add_grid) {
    abline(h = seq(-0.5, 0.5, length=11),
           v = seq(-0.5, 0.5, length=11),
           col="gray", lty=3)    
  }
}


springgreen <- c(34/255,250/255,34/255)
fuchsia <- c(250/255, 34/255, 250/255)
plot_cell(square_x, square_y, springgreen, add_grid=TRUE)
plot_cell(square_x, square_y, fuchsia, add_grid=TRUE)



# #-------------------
# # make outside the cell transparent
# library(png)
# img <- readPNG("square_cell.png")
# 
# 
# 
# ind <- which(img[, , 1] >0.75)
# for (k in 1:3) {
#   temp <- img[, , k]
#   temp[ind] <- 1
#   img[, , k] <- temp
# }
# 
# temp <- img[, , 4]
# temp[ind] <- 0
# img[, , 4] <- temp
# 
# 
# par(mar=c(0,0,0,0), bg="NA")
# plot(1, type="n", asp=1, axes = FALSE,
#      yaxs="i", xaxs="i", xlab = "", ylab = "",
#      # xlim = c(-1,2), ylim = c(-1,2)
#      xlim = c(0, 1), ylim = c(1, 0)
# )
# rasterImage(img, 0,0,1,1, interpolate = FALSE)














