# about: attemps to display tooltip correctly in echarts4r 
library(tidyverse)
library(echarts4r.assets)
library(echarts4r.suite)
library(echarts4r.maps)

sessionInfo()

# mapboox key
key <- "........"

# data
df <- read.csv("data.csv")

# setting emphasis and transparency of scatter points
transparency <- list(opacity = 0.6)
emphasis <- list(itemStyle = list(color = "#add8e6"))

# base map
p <- df %>% 
  e_charts(long) %>% 
  e_mapbox(
    token = key,
    style = "mapbox://styles/mapbox/dark-v9",
    center = c(-64.0239289,-16.35223),
    zoom = 5,
    pitch = 30
  ) 


# first variation: value argument used in e_visual_map and e_scatter_3d
p %>% 
  e_scatter_3d(lat, value, coord_system = "mapbox", bind = place, 
               itemStyle = transparency, emphasis = emphasis) %>% 
  e_visual_map(value, min = 0, max = 100, bottom = 300) %>% 
  e_tooltip() %>% 
  htmlwidgets::saveWidget(., "echarts.html")

# color range does not work and color emphasis only availaby for high values, tooltip does not work

# second variation: value argument omitted in e_visual_map and e_scatter_3d
p %>% 
  e_scatter_3d(lat, value, coord_system = "mapbox", bind = place, 
               itemStyle = transparency, emphasis = emphasis) %>% 
  e_visual_map(min = 0, max = 100, bottom = 300) %>% 
  e_tooltip() %>% 
  htmlwidgets::saveWidget(., "echarts_1.html")

# color range  and color emphasis do work, tooltip does not work regularly, it comes and goes and pops up where there are no dots

# third variation: value argument used  in e_visual_map and e_bar_3d
p %>% 
  e_bar_3d(lat, value, coord_system = "mapbox", bind = place, 
               itemStyle = transparency, emphasis = emphasis) %>% 
  e_visual_map(value, min = 0, max = 100, bottom = 300) %>% 
  e_tooltip() %>% 
  htmlwidgets::saveWidget(., "echarts_3.html")

# tooltip, works perfectly. However color range slider does not and. It only works when pointing the highest part in the bar. 
# Additionaly when zooming in squares become big and do not let to the map behind it

# fourth  variation: value argument ommited in e_visual_map and e_scatter_3d
p %>% 
  e_bar_3d(lat, value, coord_system = "mapbox", bind = place, 
           itemStyle = transparency, emphasis = emphasis) %>% 
  e_visual_map(min = 0, max = 100, bottom = 300) %>% 
  e_tooltip() %>% 
  htmlwidgets::saveWidget(., "echarts_4.html")

# everything works perfectly




