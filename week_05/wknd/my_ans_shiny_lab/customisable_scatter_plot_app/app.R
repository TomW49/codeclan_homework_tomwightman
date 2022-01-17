library(tidyverse)
library(shiny)
library(here)


students <- read_csv(here("reaction_vs_memory_app/data/students_big.csv"))

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "colour_input",
        label   = "Colour of points",
        choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")
      ),
      sliderInput(
        inputId = "transparency_input",
        label   = "Transparency of points",
        min     = 0,
        max     = 1,
        value   = 1
      ),
      selectInput(
        inputId = "shape_input",
        label   = "Shape of points",
        choices = c("Square"   = 15, 
                    "Circle"   = 16, 
                    "Triangle" = 17)
      ),
      textInput(
        inputId = "title_input",
        label = "Title of Graph",
        value = "Reaction Time vs. Memory Game"
      )
    ),
    mainPanel(
      plotOutput("reaction_vs_memory_plot")
    ) 
  )
)

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

server <- function(input, output) {
  
  output$reaction_vs_memory_plot <- renderPlot({
    students %>% 
      ggplot( 
        aes(x = reaction_time, y = score_in_memory_game, )) +
      geom_point(colour = input$colour_input,
                 shape  = as.numeric(input$shape_input),
                 alpha  = input$transparency_input) +
      ggtitle(label = input$title_input)
  })
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

shinyApp(ui = ui, server = server)
