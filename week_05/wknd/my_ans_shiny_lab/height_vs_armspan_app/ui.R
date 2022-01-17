# creating ui - radio buttons for age > 2 plots; height x count & arm_span x count

ui <- fluidPage(
  titlePanel("Height and Arm Span vs Age"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "input_age",
        label   = "Age",
        choices = age,
        inline  = TRUE
      )
    ),
    
    # displaying plots
    mainPanel(
      fluidRow(
        column(6,
               plotOutput("height_plot")
        ),
        column(6,
               plotOutput("arm_span_plot")
        )
      )
    )
  )
)



