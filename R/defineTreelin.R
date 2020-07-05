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

load(here("data","romBGC.RData"))

# Took a look at bgcROM - not worth using IMA zones.  Too inaccurate
x<-rbind(romBGC[grep(fixed("Parkland"),x),],
         romBGC[grep(fixed("Woodland"),x),])

mapview(romBGC,zcol="MAP_LABEL")

