# create dynamic information display
output$info_bar_ui <- renderUI({
  if (is.null(rv$plot_params$n_cells) || is.null(input$first_move)) {return()}
  
  # get players
  player1 <- rv$playernames[1]
  player2 <- rv$playernames[2]
  
  # get scores
  score1 <- rv$score_traj[ rv$timestep + 1 + ( (rv$timestep%%2) == (input$first_move=="1") ) ]
  score2 <- rv$score_traj[ rv$timestep + 1 + ( (rv$timestep%%2) == (input$first_move=="2") ) ]
  
  # see who is winning
  d <- score1 - score2
  leader <- rv$playernames[2-(d>0)]
  
  
  # if game is over
  if (rv$timestep==rv$plot_params$n_cells) {
    if (d == 0) { 
      leader_text <- "The game is a draw."  
      text_color <- "black"
    } 
    else {
      if (player2=="A.I.") {
        # show whether you won or lost
        leader_text <- sprintf("%s you %s by %d point%s%s",
                               ifelse(d>0, "Congratulations", "Sorry"),
                               ifelse(d>0, "won", "lost"),
                               abs(d),
                               ifelse(abs(d)==1, "",  "s"),
                               ifelse(d>0, "!", "."))
        text_color <- ifelse(d>0, "#C4A13B", "#C43B5E")
      } 
      else {
        # show winning status
        leader_text <- sprintf( "%s won by %d point%s!", leader, abs(d), ifelse(abs(d)==1, "",  "s") )
        text_color <- "#3BA3C4"
      }
    }
    
    return(
      tagList(
        fluidRow(
          column(6, h2(sprintf("%s%s Score: %d", player1, ifelse(player1=="You", "r", "'s"), score1), align = "left") ),
          column(6, h2(sprintf("%s's Score: %d", player2, score2), align = "right") )
        ),
        fluidRow( 
          h2(leader_text,
             style = paste("font-style: italic; ",
                           "margin-top:0px; ",
                           "padding-top:0px; ",
                           "color: ", text_color),
             align = "center"))
      )
    )
  }
  
  
  # if game is still going  
  if (d == 0) { leader_text <- "The game is tied " }
  else {
    leader_text <- sprintf("%s %s winning by %d point%s",
                           leader,
                           ifelse(leader=="You", "are", "is"),
                           abs(d),
                           ifelse(abs(d)==1, "",  "s")
    ) 
  }
  leader_status <- sprintf("%s with %d move%s remaining.",
                           leader_text,
                           rv$plot_params$n_cells - rv$timestep,
                           ifelse((rv$plot_params$n_cells-rv$timestep)==1, "",  "s"))
  
  # make display ui
  return(
    tagList(
      fluidRow(
        column(6, 
               h2(sprintf("%s%s Score: %d", player1, ifelse(player1=="You", "r", "'s"), score1),
                  align = "left", style = ifelse(rv$player==1, "text-decoration: underline;", ""))
        ),
        column(6, 
               h2(sprintf("%s's Score: %d", player2, score2),
                  align = "right", style = ifelse(rv$player==2, "text-decoration: underline;", ""))
        )
      ),
      
      # display who is winning and the number of moves remaining
      fluidRow( h4(leader_status, align = "center", style = "font-style: italic;") )
    )
  )
})
