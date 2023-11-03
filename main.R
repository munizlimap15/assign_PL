# Spatial Data Scientist Position - Assignment
# Wheat Production and Nitrogen Analysis

# Author: Pedro Henrique MUNIZ LIMA
# Date: Nov/2nd/2023
# Objective: Manipulate and analyze spatial datasets to generate indicators of environmental impacts associated with wheat production.

# Load necessary libraries
library(raster)       
library(rgdal)      
library(sp)  
library(sf) 
library(tidyverse)  
library(rgeos)
library(exactextractr) # Alternative to raster::extract
library(cowplot)
library(countrycode) # This one is for managing mismatching names in tables
library(mapview)     # Dynamic Viz
# Load the SPAM raster data
#Accorsingto the ReadMe_Global_v3.2.txt doccumentation:
#*_A_*		physical area
#*_H_*		harvested area
#*_Y_*		yield
raster_area      <- raster("data/SPAM_2005_v3.2/SPAM2005V3r2_global_A_TA_WHEA_A.tif")
raster_yield     <- raster("data/SPAM_2005_v3.2/SPAM2005V3r2_global_Y_TA_WHEA_A.tif")
raster_harvested <- raster("data/SPAM_2005_v3.2/SPAM2005V3r2_global_H_TA_WHEA_A.tif")

################################################
################################################
################################################
# Check resolution of each raster
res_area <- res(raster_area)
res_yield <- res(raster_yield)
res_harvested <- res(raster_harvested)

# Check extent of each raster
ext_area <- extent(raster_area)
ext_yield <- extent(raster_yield)
ext_harvested <- extent(raster_harvested)

# Compare resolutions
identical(res_area, res_yield) && identical(res_yield, res_harvested)

# Compare extents
identical(ext_area, ext_yield) && identical(ext_yield, ext_harvested)

################################################
#Assuming that the production (yield) is the area ("unit of area harvested fields = ha") multiplied by the yield....
#Assuming yield is given in tons per hectare and the area in hectares

# Calculate production volume in tons
prod_tons <- raster_area * raster_yield
# Convert production volume to million tons (Mt)
# 1 million tons = 1,000,000 tons
prod_m_tons <- prod_tons / 1000000


plot(prod_m_tons, main="Global Production Volume (in Mt)")
mapview::mapview(prod_m_tons)

# Export the raster to a GeoTIFF file
writeRaster(prod_m_tons, "prod_m_tons.tif", format="GTiff", overwrite=TRUE)

################################################
################################################
##################  TASK 2    ##################
################################################
################################################

# Load the GAUL administrative boundaries shapefile
gaul <- readOGR("data/GAUL/g2015_2005_2.shp")
summary(as.factor(gaul$ADM0_NAME))

# Load the production raster created before, if necessary
# prod_m_tons <- raster("prod_m_tons.tif")

# Aggregate production to country level using the shapefile
#production_country <- raster::extract(prod_m_tons, gaul, fun=sum, na.rm=TRUE) # Time sonsuming. Alternative below. 
production_sub_country <- exactextractr::exact_extract(prod_m_tons, gaul, fun="sum")

# Convert the list to a data frame
production_df <- data.frame(
  ADM0_NAME = gaul$ADM0_NAME,
  Production_mt = production_sub_country)

# Group by country name and summarize
production_country <- production_df %>%
  group_by(ADM0_NAME) %>%
  rename(Country = ADM0_NAME ) %>% 
  summarise(Production_mt = sum(Production_mt, na.rm = TRUE))

# Export the results to a CSV file
write.csv(production_country, "production_country.csv", row.names=FALSE)


################################################
################################################
##################  TASK 3    ##################
################################################
################################################

# Load the production raster created before, if necessary
# prod_m_tons <- raster("prod_m_tons.tif")


# Calculate the nitrogen content raster
# Since 2% of the wheat yield is nitrogen, we multiply the production raster by 0.02
nitrogen_0.2_raster <- prod_m_tons * 0.02 #2%

# Plot the nitrogen raster
plot(nitrogen_0.2_raster, main="Nitrogen Output in Harvested Wheat Yield")

# Some GGplot2 viz.while I wait the raster::extract() function or find another solution...  
# Convert the raster to a data frame
nitrogen_df <- as.data.frame(nitrogen_0.2_raster, xy = TRUE)
# Replace NA values with NA (which is redundant but ensures NAs are transparent)
nitrogen_df$layer[is.na(nitrogen_df$prod_m_tons)] <- NA

p=ggplot() +
  geom_raster(data = nitrogen_df, aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis_c(na.value = NA) + # Set NA values to be transparent
  labs(fill = "Nitrogen Output (Mt)", 
       title = "Nitrogen Output in Harvested Wheat Yield") +
  coord_sf() + 
  theme_minimal() +
  theme(panel.background = element_rect(fill = "white", colour = "white")) # Set background to white


ggsave("ggViz.png", width = 40, height = 40, units = "cm")
cowplot::plot_grid(p)
while (!is.null(dev.list()))  dev.off()


# Export the nitrogen raster to a GeoTIFF file
writeRaster(nitrogen_0.2_raster, filename="nitrogen_output.tif", format="GTiff", overwrite=TRUE)

#Among the top wheat producers, China leads in nitrogen productivity but with a low nitrogen use efficiency (NUE) of 0.26, 
#suggesting higher potential for environmental loss. In contrast, France shows a balance between high productivity and a
# higher NUE of 0.74, indicating more sustainable nitrogen usage. 
#The efficiency spectrum is broad, with countries like Kazakhstan and the Republic of Moldova achieving high NUE, 
#while the United Arab Emirates and Kuwait are at the lower end.


################################################
################################################
##################  TASK 4    ##################
################################################
################################################

# Load the dataset of country-level nitrogen use efficiency (NUE) from Zhang et al 2015
Zhang_data <- read.csv("data/NUE_Zhang_et_al_2015/Country_NUE_assumption.csv")

prod_by_country <- read.csv("production_country.csv")


# There is inconsistency in between the files and its countries names.
# The "countrycode" library might help. I will create a second field called "country2"

Zhang_data$country2      <- countrycode(Zhang_data$Country,      "country.name", "iso3c")
prod_by_country$country2 <- countrycode(prod_by_country$Country, "country.name", "iso3c")

merged_data <- merge(prod_by_country, Zhang_data, by.x = "country2", by.y = "country2")
# Basically, the NUE determines how efficient the N is being used. 
# In oter words, large yield can lead to high N losses if NUE is low. Huge amounts of N are being added in form of fertilizer.
# NUE = yield / input (from Zhang et al 2015)
# For example, if my N yield is 1kg and my NUE is 0.5, it means that to produce that 1kg of nitrogen in the wheat, I had to supply 2kg of nitrogen (N_input). 
# In other words, the NUE 0.5 suggests that for every kg of N that is harvested with the crop, two kilograms of nitrogen had to be supplied to the field.


# Merge the production data with the NUE data
merged_data <- prod_by_country %>%
  inner_join(Zhang_data, by = c("country2" = "country2")) %>%
  mutate(
    N_output = Production_mt * 0.02,    # N output is assumed to be 2% of wheat production...
    N_input = N_output / NUE,           # Total N input, calculated by dividing the nitrogen output (N_output) by the nitrogen use efficiency (NUE). This reflects the total amount of nitrogen that must be applied to achieve the observed nitrogen in the harvested crop, considering the efficiency of its use.
    N_loss = N_input - N_output         # N loss (surplus)
  ) %>%
  arrange(desc(Production_mt)) %>%
  slice(1:10) # Select the top 10 producer


# Export the top 10 as a CSV file
write.csv(merged_data, "top10_wheat_producers.csv", row.names = FALSE)



ggplot(merged_data, aes(x = reorder(country2, N_loss), y = N_output, fill = "Output")) +
  geom_bar(stat = "identity") +
  geom_bar(aes(y = -N_loss, fill = "Loss"), stat = "identity") +
  scale_fill_manual(values = c("Output" = "steelblue", "Loss" = "red"), 
                    name = "", 
                    labels = c("N Output", "N Loss")) +
  coord_flip() +
  labs(x = "Country", y = "Nitrogen (N).", caption="Values in million tons.\nSource: Zhang et al., 2015, and You et al., 2015",
       title = "Nitrogen Outputs X Losses for the top ten Wheat Producers") +
  theme_minimal() +
  guides(fill = guide_legend(reverse = TRUE)) 


# Export the plot as a PDF
ggsave("N_outputs_losses.pdf", width = 11, height = 8, units = "in")
# Export the plot as a Png
ggsave("N_outputs_losses.png", width = 11, height = 8, units = "in")

