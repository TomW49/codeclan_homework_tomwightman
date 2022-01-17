server <- function(input, output){
  
  filtered_data <- 
    reactive({students %>% 
        filter(ageyears == input$input_age)
    })
  
  output$arm_span_plot <-
    renderPlot(
      filtered_data() %>% 
        make_plot(x = "arm_span")
    )
  
  output$height_plot <- 
    renderPlot(
      filtered_data() %>% 
        make_plot(x = "height")
    )
  
}

