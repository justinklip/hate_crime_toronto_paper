#### Preamble ####
# Purpose: Simulates Toronto City Open Hate Crime Data with additional variables
# Author: Justin Klip
# Date: 21 September 2024
# Contact: justin.klip@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(31459)

# Define the start and end date
start_date <- as.Date("2018-01-01")
end_date <- as.Date("2023-12-31")

# Set the number of random records to generate
number_of_records <- 1000

# Simulate data
data <- tibble(
  id = 1:number_of_records,  # Unique row identifier
  EVENT_UNIQUE_ID = sample(100000:999999, number_of_records,
                           replace = TRUE),  # Random offence number
  OCCURRENCE_DATE = as.Date(runif(n = number_of_records,
                                  min = as.numeric(start_date),
                                  max = as.numeric(end_date)),
                            origin = "1970-01-01"),  # Random occurrence date
  OCCURRENCE_YEAR = format(OCCURRENCE_DATE, "%Y"),  # Extract year
  LOCATION_TYPE = sample(c("Residential", "Commercial", "Public",
                           "Other"), number_of_records, replace = TRUE),
  # Random location type
  AGE_BIAS = sample(c(TRUE, FALSE), number_of_records, replace = TRUE),
  # Random age bias
  MENTAL_OR_PHYSICAL_DISABILITY = sample(c(TRUE, FALSE), number_of_records,
                                         replace = TRUE),
  # Whether crime is due to disability of victim
  RACE_BIAS = sample(c("White", "Black", "Asian/Southeast Asian",
                       "South Asian", "None"), number_of_records,
                     replace = TRUE),  # Random race bias
  ETHNICITY_BIAS = sample(c("Afghan", "African", "Arab", "Chinese",
                            "Israeli", "Japanese", "Latino", "None"),
                          number_of_records, replace = TRUE),
  # Random ethnicity bias
  LANGUAGE_BIAS = sample(c("Spanish", "English", "Arabic", "Hindi",
                           "Mandarin", "None"), number_of_records,
                         replace = TRUE),  # Random language bias
  RELIGION_BIAS = sample(c("Muslim", "Jewish", "Christian", "Buddhist",
                           "Other", "None"), number_of_records,
                         replace = TRUE),  # Random religion bias
  SEXUAL_ORIENTATION_BIAS = sample(c("Gay", "2SLGBT", "None"),
                                   number_of_records, replace = TRUE),
  # Random sexual orientation bias
  GENDER_BIAS = sample(c("Male", "Female", "Transgender", "None"),
                       number_of_records, replace = TRUE),
  # Random gender bias
  PRIMARY_OFFENCE = sample(c("Assault", "Harassment", "Vandalism",
                             "Threat"), number_of_records, replace = TRUE),
  # Random primary offence
  HOOD_158 = sample(1:158, number_of_records, replace = TRUE),
  # Random neighborhood ID (158 structure)
  ARREST_MADE = sample(c(TRUE, FALSE), number_of_records, replace = TRUE)
  # Random arrest made status
)

# Set MULTIPLE_BIAS based on the number of non-"None" biases
data <- data %>%
  mutate(
    non_none_biases = rowSums(select(., RACE_BIAS, ETHNICITY_BIAS,
                                     LANGUAGE_BIAS, RELIGION_BIAS,
                                     SEXUAL_ORIENTATION_BIAS,
                                     GENDER_BIAS) != "None"),
    MULTIPLE_BIAS = ifelse(non_none_biases > 1, TRUE, FALSE)
  )

# Remove the temporary `non_none_biases` column (optional)
data <- data %>%
  select(-non_none_biases)

# View the first few rows of the data
head(data)

#### Write to CSV ####
write_csv(data, file = "data/raw_data/simulated_hate_crimes.csv")

# View the first few rows of the data
head(data, n = 17)
head(data[, 7:12])
head(data[, 12:ncol(data)])

# View the last few rows
tail(data, n = 17)
tail(data[, 7:12])
tail(data[, 12:ncol(data)])
