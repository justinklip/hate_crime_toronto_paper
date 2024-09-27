#This script checks all my code to see if there are styling errors to fix.
library(lintr)
lint("scripts/00-simulate_data.R")
lint("scripts/01-download_data.R")
lint("scripts/02-data_cleaning.R")
lint("scripts/03-test_data.R")
lint("paper/hate_crime_paper.qmd")