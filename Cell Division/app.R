library(shiny)
library(shinyjs)
library(shinythemes)
library(data.table)

# load external data
source("game_module.R",  local = TRUE)
for (f in dir(file.path("www", "functions"), full.names = TRUE, recursive = TRUE)) { source(f, local = TRUE) }


# create user interface
ui <- navbarPage(
  title = "Cell Division",
  theme=shinytheme("flatly"), 
  gameUI("petri", "Petri", icon("dot-circle-o")),
  gameUI("beaker", "Beaker", icon("table")),
  gameUI("flask", "Flask", icon("flask"))
)


# define server logic via the game modules
server <- function(input, output, session) {
  callModule(play_game, "petri", "petri_game")  
  callModule(play_game, "beaker", "beaker_game") 
  callModule(play_game, "flask", "flask_game")
}


shinyApp(ui, server)