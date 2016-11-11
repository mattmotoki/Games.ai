

library(png)
# read a sample file (R logo)
img <- readPNG("single_cell.png")



ind <- which(img[, , 1] >0.75)
for (k in 1:3) {
  temp <- img[, , k]
  temp[ind] <- 1
  img[, , k] <- temp
}

temp <- img[, , 4]
temp[ind] <- 0
img[, , 4] <- temp


par(mar=c(0,0,0,0), bg="NA")
plot(1, type="n", asp=1, axes = FALSE,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     # xlim = c(-1,2), ylim = c(-1,2)
     xlim = c(0, 1), ylim = c(1, 0)
)
rasterImage(img, 0,0,1,1, interpolate = FALSE)









#----------------
# single
r <- 0.2
theta <- seq(0, 2*pi, length.out = 100)
single_x <- r*cos(theta) + c(rep(1-r, 25), rep(r, 25), rep(r, 25), rep(1-r, 25)) - 0.5
single_y <- r*sin(theta) + c(rep(1-r, 25), rep(1-r, 25), rep(r, 25), rep(r, 25)) - 0.5
single_x <- c(single_x, single_x[1])
single_y <- c(single_y, single_y[1])

par(mar=c(0,0,0,0), bg="NA")
plot(1, type="n", asp=1, axes = FALSE,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     # xlim = c(-1,2), ylim = c(-1,2)
     xlim = c(-0.5, 0.5), ylim = c(-0.5, 0.5)
)
polygon(single_x, single_y, col="springgreen2", lwd=2)


single_x <- c(single_x, single_x[1])
single_y <- c(single_y, single_y[1])

N <- 100
# shink <- 0.99^(seq(0,15,length=N)^1.75)-0.01
shink <- seq(1,0.75,length=N)
alpha <- seq(0.075, 0, length=N)
for (k in 1:N) {
  lines(shink[k]*single_x, shink[k]*single_y, col=rgb(0,0,0,alpha[k]), lwd=5)  
}





#----------------
# triangular
r <- 0.2
r2 <- 0.15

theta <- c(seq(0, pi/2, length.out = 25), 
           seq(pi/2, 5*pi/4, length.out = 25),
           seq(5*pi/4, 2*pi, length.out = 25))

triangle_x <- c(rep(r, 25), rep(r2, 50))*cos(theta) + c(rep(1-r, 25), rep(r2*(1+sqrt(2)), 25),  rep(1-r2, 25))
triangle_y <- c(rep(r, 25), rep(r2, 50))*sin(theta) + c(rep(1-r, 25), rep(1-r2, 25),  rep(r2*(1+sqrt(2)), 25))


plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     # xlim = c(-1, 2), ylim = c(-1, 2)
     xlim = c(-0.1, 1.1), ylim = c(-0.1, 1.1)
)
# abline(h=seq(-1,2,length.out = 31), v=seq(-1,2,length.out = 31), lty=3, col="gray")
# abline(h=c(0, 1), v=c(0, 1))
polygon(triangle_x, triangle_y, col="springgreen2", lwd=2)
polygon(1-triangle_x, 1-triangle_y, col="springgreen2", lwd=2)




triangle_x <- c(triangle_x, triangle_x[1])
triangle_y <- c(triangle_y, triangle_y[1])

N <- 100
# shink <- 0.99^(seq(0,15,length=N)^1.75)-0.01
shink <- seq(1,0.75,length=N)
alpha <- seq(0.075, 0, length=N)
for (k in 1:N) {
  lines(shink[k]*triangle_x, shink[k]*triangle_y, col=rgb(0,0,0,alpha[k]), lwd=5)  
}




#----------------
# quadrilateral
r  <- 0.15
r2 <- 0.075

theta <- c(seq(0, pi/2, length.out = 25), 
           seq(pi/2, pi, length.out = 25),
           seq(pi, 5*pi/4, length.out = 25),
           seq(5*pi/4, 2*pi, length.out = 25))

quad_x <- c(rep(r, 75), rep(r2, 25))*cos(theta) + c(rep(1-r, 25), rep(0.5+r, 25),
                                               rep(0.5+r, 25),
                                               rep(1-r2, 25))
quad_y <- c(rep(r, 75), rep(r2, 25))*sin(theta) + c(rep(1-r, 25), rep(1-r, 25),
                                               rep(0.5 + r*(sqrt(2)-1), 25),
                                               rep(r2*(1+sqrt(2)), 25))


plot(1, type="n", asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     # xlim = c(-1, 2), ylim = c(-1, 2)
     xlim = c(-0.1, 1.1), ylim = c(-0.1, 1.1)
)

polygon(quad_x, quad_y, col="springgreen2", lwd=2)
polygon(1-quad_x, 1-quad_y, col="springgreen2", lwd=2)

polygon(0.5*triangle_x, 0.5*triangle_y+0.5, col="springgreen2", lwd=2)
polygon(1-0.5*triangle_x, 0.5*(1-triangle_y), col="springgreen2", lwd=2)

# abline(h=seq(-1,2,length.out = 31), v=seq(-1,2,length.out = 31), lty=3, col="gray")
# abline(h=c(0, 1), v=c(0, 1))


















