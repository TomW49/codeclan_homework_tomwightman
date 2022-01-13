library(tidyverse)
library(shiny)
library(ggradar)
library(shinythemes)

# call in data
whisky <- CodeClanData::whisky

# creates list of regions 
region <- unique(whisky$Region)


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# define UI 
ui <- fluidPage(
  
  # application title
  titlePanel("Scottish Whisky"),
  
  # sidebar with radio button
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "region_input",
        label   = "Which Region would you like to sample?",
        choices = region
      )
    ),
    mainPanel(
      plotOutput("whisky_plot")
    )
  )
)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# define server logic required to draw a radar plot
server <- function(input, output) {
  
  output$whisky_plot <- renderPlot({
    whisky %>% 
      filter(Region == input$region_input) %>%
      select(2, 7:18) %>% 
      ggradar(
        grid.min = 0,
        grid.max = 4,
        values.radar = c(0, 1, 2, 3, 4)
      )
  })
}


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #


# run the application 
shinyApp(ui = ui, server = server)