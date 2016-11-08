score_calc <- function(overlap, interlap, extensions, lone_cell) {
  4*overlap - 2*(interlap + extensions) - lone_cell + (overlap==0)
}
