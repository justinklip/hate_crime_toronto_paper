#### Preamble ####
# Purpose: Cleans the raw hate crime data downloaded from Open Data Toronto
# Author: Justin Klip
# Date: 22 September 2024
# Contact: justin.klip@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### Clean data ####

# Read raw data
hate_crime_raw_data <- read_csv("data/raw_data/hate_crime_raw_data.csv")

# Display raw data and a subset of columns
head(hate_crime_raw_data)
head(hate_crime_raw_data[7:12])

# Drop unnecessary columns (HOOD_140, NEIGHBOURHOOD_140, REPORTED_* columns)
unwanted_columns <- c("HOOD_140", "NEIGHBOURHOOD_140", "REPORTED_TIME",
                      "REPORTED_YEAR", "REPORTED_DATE", "OCCURENCE_TIME")

cleaned_hate_crime_data <- hate_crime_raw_data[,
                                               !names(hate_crime_raw_data) %in%
                                                 unwanted_columns]
# Clean column names for easier typing
cleaned_hate_crime_data <- clean_names(cleaned_hate_crime_data)

# Check the cleaned data
head(cleaned_hate_crime_data)

# Check for missing values
missing_values <- is.na(cleaned_hate_crime_data)
sum_missing_values <- sum(missing_values)

# Look at rows with missing values
na_condition <- rowSums(is.na(cleaned_hate_crime_data)) > 0
df_with_na <- cleaned_hate_crime_data[na_condition, ]
print(df_with_na, n = 37)

# Fill missing values in `location_type` column with "Unspecified"
cleaned_hate_crime_data[is.na(cleaned_hate_crime_data)] <- "Unspecified"

# Simplify `race_bias` by taking the first word before any comma
cleaned_hate_crime_data <- cleaned_hate_crime_data %>%
  mutate(race_bias = sub(",.*", "", race_bias))

# Use tibble::print() to display the first 200 rows of the `race_bias` column
print(cleaned_hate_crime_data["race_bias"])

# Simplify the location type categories
cleaned_hate_crime_data <- cleaned_hate_crime_data %>%
  mutate(location_type = case_when(
    grepl("Apartment Building|House", location_type) ~ "Residential",
    grepl("Education Institution", location_type) ~ "Educational Institution",
    grepl("Government Building", location_type) ~ "Government Building",
    grepl("Medical Facility", location_type) ~ "Medical Facility",
    TRUE ~ location_type  # Keep original value if no match
  ))

# View the updated dataframe
head(cleaned_hate_crime_data)

#### Save data ####
file_path <- "data/analysis_data/hate_crime_analysis_data.csv"

write_csv(cleaned_hate_crime_data, file_path)
