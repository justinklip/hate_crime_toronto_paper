#### Preamble ####
# Purpose: Tests the Data for to check if everything is order
# Author: Justin Klip
# Date: 22 September 2024 [...UPDATE THIS...]
# Contact: justin.klip@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-data_cleaning.R
# Any other information needed? None


### Workspace setup ###
library(tidyverse)

### Data Acquisition ###
hate_crime_analysis_data <- read_csv(
  "data/analysis_data/hate_crime_analysis_data.csv"
)
#### Test data ####

# One: NA Test
sum(is.na(hate_crime_analysis_data))

# Two: Duplicates Test
sum(duplicated(hate_crime_analysis_data))

# Three : Empty String Test
sum(hate_crime_analysis_data$location_type == "")
sum(hate_crime_analysis_data$race_bias == "")
sum(hate_crime_analysis_data$ethnicity_bias == "")
sum(hate_crime_analysis_data$religion_bias == "")
sum(hate_crime_analysis_data$sexual_orientation_bias == "")
sum(hate_crime_analysis_data$primary_offence == "")
sum(hate_crime_analysis_data$gender_bias == "")
sum(hate_crime_analysis_data$division == "")

# Four: Look at data set for any glaring issues
summary(hate_crime_analysis_data)

#Since most of our data is string data, this isn't a surprising result.
