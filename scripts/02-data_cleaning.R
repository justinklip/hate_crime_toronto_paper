#### Preamble ####
# Purpose: Cleans the raw hate crime data downloaded from Open Data Toronto
# Author: Justin Klip 
# Date: 22 September 2024
# Contact: justin.klip@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 01-download_data.R
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(janitor)
#### Clean data ####

hate_crime_raw_data <- read_csv("data/raw_data/hate_crime_raw_data.csv")

hate_crime_raw_data
head(hate_crime_raw_data[7:12])


#Most of our variable names are pretty clear, except hood and neighborhood
#For these, delete the old version which is 140 version, we already have updated 158 version
#Also not really interested in time of event for this paper, or reported date, remove those too.
cleaned_hate_crime_data <- hate_crime_raw_data[,!names(hate_crime_raw_data) %in% c("HOOD_140", "NEIGHBOURHOOD_140", "REPORTED_TIME", "REPORTED_YEAR", "REPORTED_DATE", "REPORTED_TIME", "OCCURENCE_TIME")]

#Make the column names easier to type
cleaned_hate_crime_data <- clean_names(cleaned_hate_crime_data)

#Examine the data
cleaned_hate_crime_data

#Confirm if there are any missing values
is.na(cleaned_hate_crime_data)

#There appears to be one, sum to find out how many there are
sum(is.na(cleaned_hate_crime_data))

#Look at the rows in question
df_with_na <- cleaned_hate_crime_data[rowSums(is.na(cleaned_hate_crime_data)) > 0, ]
print(n = 37, df_with_na)

#They all are specifically for location type, so we'll just rename to unspecified
cleaned_hate_crime_data[is.na(cleaned_hate_crime_data)] <- "unspecified"


#### Save data ####
write_csv(cleaned_hate_crime_data, "data/analysis_data/hate_crime_analysis_data.csv")
