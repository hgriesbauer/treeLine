# Define the treeline in northern BC

library(tidyverse)
library(bcdata)
library(sf)
library(mapview)
library(here)

## Download BGC data for Omineca region
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

load(here("data","bgcROM.RData"))

# Took a look at bgcROM - not worth using IMA zones.  Too inaccurate
x<-rbind(bgcROM[grep(fixed("Parkland"),x),],
         bgcROM[grep(fixed("Woodland"),x),])

mapview(x,zcol="MAP_LABEL",fillOpacity=0.1)

