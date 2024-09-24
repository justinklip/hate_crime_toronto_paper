#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Justin Klip
# Date: 21 September 2024
# Contact: justin.klip@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#Get libraries
library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("hate-crimes-open-data")
package

# get all resources for this package
resources <- list_package_resources("hate-crimes-open-data")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
hate_crime_raw_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
hate_crime_raw_data

#### Save data ####
#save to the raw data folder
write_csv(hate_crime_raw_data, "data/raw_data/hate_crime_raw_data.csv") 

         
