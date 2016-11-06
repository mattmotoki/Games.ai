#------------
# Print Debugging Information
print_debug <- function(rv, player) {
  cat(paste0("\n\n\n\nPlayer: ", player, ",  Move: ", length(rv$open_pos)), "\n")

  cat("\nOverlap\n")
  print(rv$overlap[[player]][(rv$h+2):3, 3:(rv$w+2)])
  
  cat("\nInterlap\n")
  print(rv$interlap[[player]][(rv$h+2):3, 3:(rv$w+2)])
  
  cat("\nExtensions\n")
  print(rv$extensions[[player]][(rv$h+2):3, 3:(rv$w+2)])
  
  cat("\nlone_cell\n")
  print(rv$lone_cell[[player]][(rv$h+2):3, 3:(rv$w+2)])

    
  # cat("\nOverlap\n")
  # print(rv$overlap[[player]][(rv$h-2):3, 3:(rv$w-2)])
  # 
  # cat("\nInterlap\n")
  # print(rv$interlap[[player]][(rv$h-2):3, 3:(rv$w-2)])
  # 
  # cat("\nExtensions\n")
  # print(rv$extensions[[player]][(rv$h-2):3, 3:(rv$w-2)])
  # 
  # cat("\nlone_cell\n")
  # print(rv$lone_cell[[player]][(rv$h-2):3, 3:(rv$w-2)])
  
  # cat("\nReward\n")
  # reward <- matrix(0, rv$h, rv$w)
  # reward[-rv$open_pos] <- -Inf
  # reward[rv$open_pos] <- score_calc(player, rv$open_pos)
  # print(reward[(rv$h-2):3, 3:(rv$w-2)])
  
}