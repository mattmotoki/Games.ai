# # Map Moves to Their Respective Scores
# score_calc <- function(rv, player, moves) {
#   4*rv$overlap[[player]][moves] - 2*(rv$interlap[[player]][moves] + rv$extensions[[player]][moves]) -
#     rv$lone_cell[[player]][moves] + (rv$overlap[[player]][moves]==0)
# }



score_calc <- function(overlap, interlap, extensions, lone_cell) {
  4*overlap - 2*(interlap + extensions) - lone_cell + (overlap==0)
}
