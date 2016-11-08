mainPanel(
  width = 7,
  fluidPage(
    #------------
    # Information Bar 
    uiOutput(ns("info_bar_ui")),
    
    
    #------------
    # Display Board
    fluidRow( 
      column(12, 
             plotOutput(
               ns("board_plot"),
               click = ns("plot_click"),
               hover = hoverOpts(id = ns("plot_hover"), delay = 100, delayType = "throttle"),
               height = 450, width = 450) 
      ),
      align="center"
    ),
    
    
    #------------
    # Game Help
    
    # help text
    fluidRow(uiOutput(ns("help_text")), align="center"),
    
    # buttons to show when game is over
    hidden(
      fluidRow(
        id = ns("game_over_buttons"),
        column(10, 
               offset=1,
               column(6, 
                      actionButton(ns("play_again"), "Play Again", icon=icon("play"), width="125px"),
                      align="left"),
               column(6,
                      actionButton(ns("switch_turns"), "Switch Turns", icon=icon("exchange"), width="125px"),
                      align="right")
        )
      )
    ),
    
    # buttons to show when game in progress
    hidden(
      fluidRow(
        id = ns("game_play_buttons"),
        column(10, 
               offset=1,
               column(6, 
                      actionButton(ns("undo_move"), "Undo Move", icon=icon("rotate-left"), width="125px"), 
                      align="left"),
               column(6,
                      actionButton(ns("reset_game"), "Reset Game", icon=icon("refresh"), width="125px"),
                      align="right")
        )
      )
    )
  )
)