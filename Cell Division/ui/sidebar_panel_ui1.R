fluidPage(
  id = ns("sidebar_panel1"), 
  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {border: black; background: #C4A13B}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {border: black; background: #C4A13B}")),
  tags$style(HTML(".js-irs-2 .irs-single, .js-irs-2 .irs-bar-edge, .js-irs-2 .irs-bar {border: black; background: #C4A13B}")),
  
  # get the size of the board
  fluidRow( h4(actionLink(ns("board_size_link"), "Board Size", icon=icon("sort"))) ),
  fluidRow( id = ns("board_size_section"), uiOutput(ns("board_size_ui")) ),
  
  
  # Opponent difficulty
  fluidRow(h4(actionLink(ns("player_options_link"), "Player Options", icon=icon("user")))),
  fluidRow(
    id = ns("player_options_section"),
    column(6,
           fluidRow( radioButtons(ns("player_mode"), "Mode", list("A.I."="1", "Two Player"="2"), selected = "1") ),
           fluidRow( radioButtons(ns("adaptive"), "Adaptive", list("On" = "1", "Off"="0"), selected = "0" ) ), 
           align="left"
    ),
    column(6,
           fluidRow( uiOutput(ns("first_move_ui")) ),
           fluidRow( radioButtons(ns("difficulty"), "Difficulty", list("Easy"="1", "Medium"="2", "Hard"="3"), selected="2") ),
           fluidRow( sliderInput(ns("skill"), "A.I. Skill", value=75, min=1, max=100, ticks=FALSE) ), 
           align="right"
    )
  ),
  
  
  # Visual Controls
  fluidRow( h4(actionLink(ns("visual_contols_link"), "Visual Controls", icon=icon("eye"))) ),
  fluidRow(
    id = ns("visual_contols_section"),
    fluidRow(
      column(6, 
             radioButtons(ns("show_help"), "Show Help", choices = list("On"="1", "Off"="0"), selected="0", inline = TRUE), 
             align="left"),
      column(6, 
             radioButtons(ns("view_connections"), "View Connections", choices = list("On"="1", "Off"="0"), inline = TRUE), 
             align="right")
    )
  )
  
  
  # # control buttons
  # br(),
  # fluidRow(
  #   fluidRow(
  #     column(6, actionButton(ns("undo_move"), "Undo Move", icon=icon("rotate-left"), width="125px"), align="left"),
  #     column(6, actionButton(ns("reset_game"), "Reset Game", icon=icon("refresh"), width="125px"), align="right")
  #   )
  # )
  # 
  # # Extra Moves
  # fluidRow(h4(actionLink(ns("extra_moves_link"), "Extra Moves", icon=icon("medkit")))),
  # fluidRow(
  #   id = ns("extra_moves_section"),
  #   fluidRow(
  #     column(6, numericInput("acid_base_count", "NaOH/HCl", min=1, max=10, value=0) ),
  #     column(6, numericInput("alcohol_count", "Isopropyl Alcohol", min=1, max=10, value=0) )
  #   )
  # )
  
  
)