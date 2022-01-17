library(shiny)
library(tidyverse)
library(here)

students <- read.csv(here("three_different_plot_options_app/data/students_big.csv"))

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons("plot_type_input", "Plot Type",
                   choices = c("Bar",                  
                               "Horizontal Bar",
                               "Stacked Bar"     
                   )                     
      )
    ),
    
    mainPanel(
      plotOutput("plot_type")
    )
  )
)


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

server <- function(input, output) {
  
  output$plot_type <- renderPlot({
    if(input$plot_type_input == "Bar",
            ggplot(students,
                   aes(x = handed, fill = gender)) +
              geom_bar(position = "dodge") 

       (input$plot_type_input == "Horizontal Plot",
                    ggplot(students,
                           aes(x = handed, fill = gender)) +
                      geom_bar(position = "dodge") +
                      coord_flip(),
                    
                    ggplot(students,
                           aes(x = handed, fill = gender)) +
                      geom_bar()
            )
    )
  })
}


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#


shinyApp(ui = ui, server = server)

