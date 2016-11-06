source(file.path("www", "functions", "initialize_petri.R"),  local = TRUE)

x <- list(a=1, b=2, c=3)
c <- with(x, {
  d <- a + b
  c <- c + d
  c
})

c

w <- 5
h <- 1

f <- new_petri(h, w)

plot(0, type="n",  asp=1,
     yaxs="i", xaxs="i", xlab = "", ylab = "",
     xlim=f$box_lim_x, ylim=f$box_lim_y
)
polygon(f$fill_x, f$fill_y, col = "red", border = NA)
lines(f$grid_x, f$grid_y, lwd=1.5, lty=3)

h <- 2*w
w <- 2*w

# make blank board
board <- matrix(-Inf, h, w)

# add left and right margins
margin <-  matrix(rep(-Inf, 2*h), h, 2)
board <- cbind(margin, board, margin)

# add top and bottom margins
margin <-  matrix(rep(-Inf, 2*(w+4)), 2, w+4)
board <- rbind(margin, board, margin)


# make indices
keep <- !(is.na(f$grid_x) | is.na(f$grid_y))
top <- f$grid_y[keep][seq(1, sum(keep), 2)]-1
bot <- f$grid_y[keep][seq(2, sum(keep), 2)]
left_open_pos <- do.call("c", lapply( 1:(w/2 + ((w/2)%%1) ), function(k) sub2ind(bot[k]:top[k], k) ) )
right_open_pos <- do.call("c", lapply( (w/2+2+ ((w/2)%%1) ):(w+1), function(k) sub2ind(bot[k]:top[k], k-1) ) )


open_pos <- c(left_open_pos, right_open_pos)
board[open_pos] <- 0

board[(h+4):1, ]



 
# source(file.path("www", "functions", "initialize_beaker.R"),  local = TRUE)
# w <- 4
# h <- 5
# 
# 
# f <- new_beaker(h, w)
# 
# plot(0, type="n",  asp=1,
#      yaxs="i", xaxs="i", xlab = "", ylab = "",
#      xlim=f$box_lim_x, ylim=f$box_lim_y
# )
# polygon(f$fill_x, f$fill_y, col = "red", border = NA)
# lines(f$grid_x, f$grid_y, lwd=1.5, lty=3)
# 
# open_pos <- sub2ind( rep(1:h, each=w), rep(1:w, h))
# 
# # make blank board
# board <- matrix(-Inf, h, w)
# 
# # add left and right margins
# margin <-  matrix(rep(-Inf, 2*h), h, 2)
# board <- cbind(margin, board, margin)
# 
# # add top and bottom margins
# margin <-  matrix(rep(-Inf, 2*(w+4)), 2, w+4)
# board <- rbind(margin, board, margin)
# 
# board[open_pos] <- 0
# 
# board[(h+4):1, ]


# source(file.path("www", "functions", "initialize_flask.R"),  local = TRUE)
# 
# 
# neck_h <- 7
# w <- 4
# h <- w/2+neck_h
# 
# f <- new_flask(neck_h, w)
# 
# plot(0, type="n",  asp=1,
#      yaxs="i", xaxs="i", xlab = "", ylab = "",
#      xlim=f$box_lim_x, ylim=f$box_lim_y
# )
# polygon(f$fill_x, f$fill_y, col = "red", border = NA)
# lines(f$grid_x, f$grid_y, lwd=1.5, lty=3)
# 
# 
# 
# 
# # adjacent indices w.r.t a board with a margin, row and col w.r.t. no margin)
# sub2ind = function(row, col) { (col+1)*(h+4) + row+2 }
# 
# # make blank board
# board <- matrix(-Inf, h, w)
# 
# # add left and right margins
# margin <-  matrix(rep(-Inf, 2*h), h, 2)
# board <- cbind(margin, board, margin)
# 
# # add top and bottom margins
# margin <-  matrix(rep(-Inf, 2*(w+4)), 2, w+4)
# board <- rbind(margin, board, margin)
# 
# 
# # make indices
# keep <- !(is.na(f$grid_x) | is.na(f$grid_y))
# top <- f$grid_y[keep][seq(2, sum(keep), 2)]-1
# left_open_pos <- do.call("c", lapply( 1:(w/2), function(k) sub2ind(1:top[k], k) ) )
# right_open_pos <- do.call("c", lapply( (w/2+2):(w+1), function(k) sub2ind(1:top[k], k-1) ) )
# 
# open_pos <- c(left_open_pos, right_open_pos)
# board[open_pos] <- 0
# 
# board[(h+4):1, ]
# 
# 
# rm(keep, top, margin, left_open_pos, right_open_pos)
# 
# 
# bot <- b$grid_y[keep][seq(1, sum(keep), 2)]
# 
# sum(rm_inds)
# y <- b$grid_y[!rm_inds]












/