#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Justin Klip
# Date: 21 September 2024
# Contact: justin.klip@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
# Load required libraries
library(opendatatoronto)
library(dplyr)

#### Download and process data ####
# Get package metadata for Toronto hate crime data
hate_crime_package <- show_package("hate-crimes-open-data")
hate_crime_package

# Get all resources for this package
resources <- list_package_resources("hate-crimes-open-data")

# Identify datastore resources; by default, Toronto Open Data sets the
# datastore resource format to CSV for non-geospatial data and GeoJSON for
# geospatial data.
datastore_resources <- resources %>%
  filter(tolower(format) %in% c("csv", "geojson"))

# Load the first datastore resource as a sample
hate_crime_raw_data <- datastore_resources %>%
  filter(row_number() == 1) %>%
  get_resource()
hate_crime_raw_data

#### Save data ####
# Save the raw hate crime data to the raw_data folder
write_csv(hate_crime_raw_data, "data/raw_data/hate_crime_raw_data.csv")
