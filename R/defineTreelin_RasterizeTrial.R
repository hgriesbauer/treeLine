# Define the treeline in northern BC

library(dplyr)
library(sf)
library(GSIF)
library(mapview)
library(stars)
library(tidyverse)
library(here)
library(rgdal)
library(raster)
library(rasterVis)


?## Download BGC data for Omineca region
# rom<-
#   bcdc_query_geodata("natural-resource-nr-regions") %>% 
#   filter(ORG_UNIT=="ROM") %>% 
#   collect()

# First, load BEC data into your workspace 
# by querying BGC data and filtering for DPG
# bgcROM <- bcdc_query_geodata("WHSE_FOREST_VEGETATION.BEC_BIOGEOCLIMATIC_POLY") %>% 
#   filter(INTERSECTS(rom)) %>% 
#   filter(ZONE %in% c("IMA","BAFA","ESSF")) %>% 
#   collect()
# save(bgcROM,file=here("data","bgcROM.RData"))

load(here("data","romBGC.RData"))


aoi_sf <- 
  bcmaps::nr_districts() %>% 
  filter(ORG_UNIT=="DJA")

# Define AOI
aoi_sf <-
  bcmaps::nr_regions() %>%
  filter(ORG_UNIT == "ROM")

# Rasterize 
x<-
  romBGC %>% 
  st_intersection(aoi_sf) %>% 
  filter(ZONE %in% c("ESSF","SWB","IMA","BAFA")) %>% 
  dplyr::select(MAP_LABEL,geometry) %>% 
  mutate(BGC=factor(MAP_LABEL))
  
raster.x<-raster()
extent(raster.x)<-extent(x)
res(raster.x)<-30
bec.r<-rasterize(x,raster.x,field="BGC")

plot(bec.r,"MAP_LABEL")
writeRaster(bec.r, filename="becRaster.tif")

bec.r2<-projectRaster(bec.r,crs=3005)
