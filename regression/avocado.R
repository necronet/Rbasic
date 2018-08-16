# Avocado example of regression and exploration of data
# Ref: https://www.kaggle.com/neuromusic/avocado-prices#
require(readr)
#require(dplyr)
require(ggplot2)
#require(ggmap)
require(maps)
require(tidyverse)

avocado_data <- read_csv('regression/data/avocado.csv')

# Remove an extra column that is just a row number.
avocado_data <- avocado_data[,-1]
names(avocado_data)

regions_mt <- avocado_data$region %>% factor %>% levels

regions_coordinates <- geocode(regions_mt)
regions_with_coords <- cbind(regions_mt,regions_coordinates)

regions_with_coords_f <- regions_with_coords %>% filter(!is.na(lat))

usa <- map_data("usa") # we already did this, but we can do it again
gg1 <- ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group),
               fill = "gray", color = "black") + 
  coord_fixed(1.3)

gg1 <- gg1 + geom_point(data = regions_with_coords_f, aes(x = lon, y = lat), color = "black", size = 2) +
  geom_point(data = regions_with_coords_f, aes(x = lon, y = lat), color = "green", size = 1) +
  ggtitle('Where is the data located?') + xlab('') + ylab('')
gg1

avocado_data_with_coords <- merge(avocado_data, regions_with_coords_f,by.x="region",by.y="regions_mt")

dim(avocado_data_with_coords)
