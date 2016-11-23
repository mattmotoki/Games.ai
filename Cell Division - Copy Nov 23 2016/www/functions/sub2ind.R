
# adjacent indices w.r.t a board with a margin, row and col w.r.t. no margin)
sub2ind <- function(row, col, h) { (col+1)*(h+4) + row+2 }
