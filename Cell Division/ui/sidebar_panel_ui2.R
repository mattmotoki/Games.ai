
fluidPage(
  id = ns("sidebar_panel2"),
  
  
  # Visual Controls
  fluidRow( h4(actionLink(ns("show_connections"), "Visual Controls", icon=icon("eye"))) ),
  fluidRow(
    column(6, 
           radioButtons(ns("show_help"), "Show Help", choices = list("On"="1", "Off"="0")), 
           align="left"),
    column(6, 
           radioButtons(ns("view_connections"), "View Connections", choices = list("On"="1", "Off"="0")), 
           align="right")
  ),
  
  
  # # Select Moves
  # fluidRow( h4(actionLink(ns("select_move"), "Select Move", icon=icon("medkit"))) ),
  # fluidRow(
  #   column(6, 
  #          radioButtons(ns("move1"), "Player 1", choices = list("Green Cell"="1", "NaOH"="2", "Alcohol"="3")), 
  #          align="left"),
  #   column(6, 
  #          radioButtons(ns("move2"), "Player 2", choices = list("Red Cell"="1", "HCl"="2", "Alcohol"="3")), 
  #          align="right")
  # ),
  
  
  # control buttons
  br(),
  fluidRow(
    column(6, actionButton(ns("undo_move"), "Undo Move", icon=icon("rotate-left"), width="125px"), align="left"),
    column(6, actionButton(ns("reset_game"), "Reset Game", icon=icon("refresh"), width="125px"), align="right")
  )
  
) 
