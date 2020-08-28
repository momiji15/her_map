#packages
library(sp)
library(sf)
library(tidyverse)
library(here)

# reading in the points
poi <- st_read(here("data", "ca_points", "ca_points_wgs84.gpkg"))

#poi <- poi %>%
#  rename(c(Category = Categry, Contact = Cntct_P)) %>%
#  select(Name, Category, Address, City, State, Zipcode, Contact, Email, Phone, Website, Notes)

poi <- poi %>%
  select(Name, Category, Address, City, State, Zipcode, Contact_Person, Email, Phone, Website, Notes)

select_category <- sort(unique(poi$Category))
select_city <- sort(unique(poi$City))
select_state <- sort(unique(poi$State))




