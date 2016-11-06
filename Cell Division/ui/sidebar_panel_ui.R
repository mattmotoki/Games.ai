sidebarPanel(
  width = 4,
  
  #--------------
  # header
  fluidRow(
    column(12, p("Game Options", style = "color: #3BC4A1; font-size:24pt; padding:0px; margin:0px;"), align = "center")
  ),
  
  #--------------
  # controls
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
    )
  ),
  
  #--------------
  # footnote
  fluidRow( hr(style="background-color: #D0D0D0; height: 1px;") ),
  fluidRow(
    column(12,
           tags$a(href = "https://github.com/mattmotoki/Games.ai/tree/master/Cell%20Division", target = "_blank",
                  HTML('Created by Matt Motoki <i class="fa fa-github" aria-hidden="true"></i>'),
                  style = "color: #3BA3C4"),
           align = "center"            
    )
  )
)