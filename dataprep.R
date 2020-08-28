library(here)
library(tmap)
library(sf)
library(tidyverse)
library(leaflet)
library(rgdal)

############################### CREATING A SHAPEFILE ############################### 
### California Albers EPSG: 3310
ca_points <- read_csv(here("data", "ca_addresses.csv"))

#ca_points_ca_albers <- ca_points %>%
#  st_as_sf(coords = c("Longitude", "Latitude"), crs = 3313)

ca_points_wgs_84 <- ca_points %>%
  st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326) %>%
  rename(Lat2 = Latitude...15, Long2 = Longitude...16) %>%
  select(-c("FID")) #had to remove the FID because it was creating an error


st_write(ca_points_wgs_84, here("data", "ca_points", "ca_points_wgs84.gpkg"))

#creating shapefiles
#st_write(ca_points_ca_albers, "ca_points_albers.shp")
#write_sf(ca_points_wgs_84, here("data", "ca_points", "ca_points_wgs84.gpkg"))

#creating geopackages (they are better to use to be honest)
st_write

################################ MAPPING THE POINTS ################################ 

ca_addresses <- st_read(here("data", "ca_points", "ca_points_wgs84.shp"))
ca_addresses <- st_read(here("data", "ca_points", "ca_points_wgs84.gpkg"))
ca_addresses <- st_read()

leaflet(ca_addresses) %>%
  addTiles() %>%
  addMarkers()
  
  