library(tidyverse)
library(shiny)
library(ggradar)
library(shinythemes)

# call in data
whisky <- CodeClanData::whisky

# creates list of regions 
region <- unique(whisky$Region)

# creates reactive list of distilleries based on input region 
distillery <- whisky %>% 
  filter(Region == region_input) %>%
  select(2) %>% 
  pull()

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
      ),
      selectInput(
        inputId = "distilery_input",
        label   = "Distillery",
        choices = ""
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
server <- function(input, output, session) {
  
  output$whisky_plot <- renderPlot({
    whisky %>% 
      filter(Region == input$region_input) %>%
      filter(Distillery == input$distillery_input) %>% 
      select(2, 7:18) %>% 
      ggradar(
        grid.min = 0,
        grid.max = 4,
        values.radar = c(0, 1, 2, 3, 4)
      )
  })
  observe({
    updateSelectInput(session, "distilery_input", choices = outVar()
    )})
}


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #


# run the application 
shinyApp(ui = ui, server = server)