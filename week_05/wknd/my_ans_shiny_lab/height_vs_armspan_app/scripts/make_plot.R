# creating function to make plots

make_plot <- function(filtered_data, x){
  filtered_data %>% 
  ggplot(
    aes(x = .data[[x]])) +
    geom_bar() 
}