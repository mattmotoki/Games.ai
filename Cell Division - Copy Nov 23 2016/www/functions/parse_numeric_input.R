parse_numeric_input <- function(user_input, lower, upper, step=1) {
  ifelse(is.numeric( user_input), min(max(round(user_input/step)*step, lower), upper), NA)
}