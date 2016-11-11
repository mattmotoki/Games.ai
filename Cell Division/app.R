library(shiny)
library(shinyjs)
library(shinythemes)
library(data.table)

# load external data
source("game_module.R",  local = TRUE)
for (f in dir(file.path("www", "functions"), full.names = TRUE, recursive = TRUE)) { source(f, local = TRUE) }

ui <- navbarPage(
  title = tags$a(
    href = "https://github.com/boto/boto#user-content-finding-out-more-about-boto",
    p(tags$img(src = file.path("figures", "small_single_cell.png"), style="height:25px; vertical-align: text-top"),
      "Cell Division Prototype", style="margin:0; padding:0;"),
    target = "_blank",
    style = "color: #3BA3C4"),
  
  
  theme=shinytheme("flatly"), 
  gameUI("petri", "Petri Dish", icon("dot-circle-o")),
  gameUI("beaker", "Beaker", icon("table")),
  gameUI("flask", "Erlenmeyer Flask", icon("flask"))
)

server <- function(input, output, session) {
  callModule(play_game, "petri", "petri_game")  
  callModule(play_game, "beaker", "beaker_game") 
  callModule(play_game, "flask", "flask_game")
}


shinyApp(ui, server)