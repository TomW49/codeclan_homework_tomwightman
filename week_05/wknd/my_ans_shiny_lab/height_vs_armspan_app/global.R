library(tidyverse)
library(shiny)

students <- read_csv("data/students_big.csv")

# retrieving and running script to extract age from data
source("scripts/age_script.R")

# retrieving and running script to extract age from data
source("scripts/make_plot.R")