# section folding settings
observeEvent(input$board_size_link, toggle("board_size_section", anim=TRUE))
observeEvent(input$player_options_link, toggle("player_options_section", anim=TRUE))
observeEvent(input$visual_contols_link, toggle("visual_contols_section", anim=TRUE))

# display settings for adaptive or fixed difficulty
observeEvent(input$adaptive, {
  toggle("difficulty", condition = (input$adaptive=="0"), anim = TRUE)
  toggle("skill", condition = (input$adaptive=="1"), anim = TRUE)
})

