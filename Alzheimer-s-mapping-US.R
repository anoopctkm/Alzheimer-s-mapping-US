library(tidyverse)
library(scales)
library(maps)
library(mapproj)
dt_ad <- read.csv("~/Downloads/ALZHEIMERS2016.csv")
head(dt_ad)
Load the map data of the U.S. states

dt_states = map_data("state")
head(dt_states)

#get the state name from URL
dt_ad2 = dt_ad %>% 
  separate(URL, c("a","b","c","d", "region"), sep="/") %>% 
  select(RATE, region)
# removing white space for mergin purposes
dt_states2 = dt_states %>%
  mutate(region = gsub(" ","", region))
# merge
dt_final = left_join(dt_ad2, dt_states2)

Visualization
The dt_final dataset have all the variables I need to make the map.

ggplot(dt_final, aes(x = long, y = lat, group = group, fill = RATE)) + 
  geom_polygon(color = "white") +
  scale_fill_gradient(
    name = "Death Rate", 
    low = "#fbece3", 
    high = "#6f1873", 
    guide = "colorbar",
    na.value="#eeeeee", 
    breaks = pretty_breaks(n = 5)) +
  labs(title="Mortality of Alzheimer Disease in the U.S.", x="", y="") +
  coord_map()
  
