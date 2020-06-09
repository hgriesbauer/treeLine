library(raster)

r <- raster(nrow=18, ncol=36, xmn=0)
r[150:250] <- 1
r[251:450] <- 2
plot( boundaries(r, type='inner') )
plot( boundaries(r, type='outer') )
plot( boundaries(r, classes=TRUE) )


library(elevatr)

# Get Omineca Resource region
library(bcdata)
library(here)
library(ggplot2)
library(sf)
library(rgeos)
library(sp)

rom<-  # Create new spatial feature called dpg
  bcdc_query_geodata("natural-resource-nr-regions") %>%  # query the nr district dataset 
  filter(ORG_UNIT=="ROM") %>% # filter for Prince George District
  collect() # and download it 

romBGC <- bcdc_query_geodata("WHSE_FOREST_VEGETATION.BEC_BIOGEOCLIMATIC_POLY") %>% 
  filter(INTERSECTS(rom)) %>% # Note the different way to filter
  collect()

romBGC_crop<-
  raster::intersect(romBGC,rom)

romBGC_crop %>% ggplot()+geom_sf()

rom_el <- get_elev_raster(rom, z = 9)
plot(rom_el)
save(rom_el,file=here("data","rom_elevation.RData"))
