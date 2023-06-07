install.packages(c("raster", "rgdal", "sp", "dplyr", "tidyverse", "ggplot2"))

### Task 1
library(raster)

# Set the path to the SPAM datasets
spam_folder <- "data/SPAM_2005_v3.2/"

# Read the yield, physical area, and harvested area rasters
yield_raster <- raster(paste0(spam_folder, "SPAM2005V3r2_global_Y_TA_WHEA_A.tif"))
area_raster <- raster(paste0(spam_folder, "SPAM2005V3r2_global_A_TA_WHEA_A.tif"))
harvest_raster <- raster(paste0(spam_folder, "SPAM2005V3r2_global_H_TA_WHEA_A.tif"))

# Calculate wheat production volume (in Mt)
# NB! According to SPAM 2005 Technical Documentation, yield is in Kg/Ha and harvested area is in Ha;
# 1 Mt = 10^6 t = 10^9 kg
wheat_production_raster <- yield_raster * harvest_raster / (10^9)

# Set the path to export the raster
export_path <- "output/wheat_production_raster.tif"

# Export the raster as a GeoTIFF file
writeRaster(wheat_production_raster, export_path, format = "GTiff", overwrite = TRUE)

###Produce a global map
install.packages(c("rasterVis"))
library(rasterVis)
library(ggplot2)

# Read the wheat production raster
wheat_production_raster <- raster("output/wheat_production_raster.tif")

# Set up the plot parameters
par(mar = c(4, 4, 2, 2))
plot(wheat_production_raster, 
     col = rev(terrain.colors(8)), 
     main = "Global Wheat Production (Mt)",
     xlab = "Latitude", 
     ylab = "Longitude")

# Export the plot as a PNG file
export_path <- "output/global_wheat_production_map.png"
ggsave(export_path, plot = last_plot(), dpi=700, device = "png")
dev.copy(png, export_path)
dev.off()


###Task 2
library(rgdal)
install.packages("sf")
library(sf)
library(terra)
# Set the path to the GAUL shapefile
# gaul_path <- "data/GAUL/g2015_2005_2.shp"

# Read the GAUL shapefile
# gaul_shapefile <- readOGR(gaul_path)

# Aggregate polygons by country
# gaul_country <- aggregate(gaul_shapefile, by = "ADM0_NAME")

###Due to the processing power limitations, aggregation above could not be performed. The task was completed
###using the national units taken from https://data.europa.eu/data/datasets/jrc-10112-10004?locale=en
###Running the task in QGIS was corrupted due to invalid geometries which could have resulted in inaccurate results
###however, with more processing power available, R code above should be sufficient 

# Set the path to the GAUL shapefile
#gaul_path <- "GIS/gaul_country.shp"
gaul_path <- "data/GAUL0/gaul0_asap.shp"

# Read the GAUL shapefile
gaul_shapefile <- readOGR(gaul_path)

# Aggregate wheat production to country level
wheat_production_country <- raster::extract(wheat_production_raster, gaul_shapefile, fun = sum, na.rm = TRUE)

# Create a data frame with country names and production values
production_df <- data.frame(Country = gaul_shapefile$name0, Wheat_Production = wheat_production_country)

# Set the path to export the CSV file
export_path <- "output/wheat_production_country.csv"

# Export the data frame as a CSV file
write.csv(production_df, export_path, row.names = FALSE)

###Task 3
# Assuming 2% of harvested wheat yield consists of nitrogen (N) element
n_output_raster <- wheat_production_raster * 0.02

# Set the path to export the raster
export_path <- "output/n_output_raster.tif"

# Export the raster as a GeoTIFF file
writeRaster(n_output_raster, export_path, format = "GTiff")

###Plotting the N output

# Read the nitrogen output raster
n_output_raster <- raster("output/n_output_raster.tif")

# Set up the plot parameters
par(mar = c(4, 4, 2, 2))
plot(n_output_raster, 
     col = rev(heat.colors(6)), 
     main = "Global Nitrogen Output in Harvested Wheat Yield (Mt)",
     xlab = "Latitude", 
     ylab = "Longitude")

# Export the plot as a PNG file
export_path <- "output/nitrogen_output_map.png"
ggsave(export_path, plot = last_plot(), dpi = 700, device = "png")
dev.copy(png, export_path)
dev.off()


###Task 4
library(dplyr)
#Set the path to the NUE shapefile
nue_path <- "data/NUE_Zhang_et_al_2015/Country_NUE_assumption.csv"
# Read the NUE dataset
nue_dataset <- read.csv(nue_path)

# Join NUE dataset with wheat production dataset based on country names
result_df <- inner_join(production_df, nue_dataset, by = c("Country" = "Country"))

# Select the 10 biggest wheat producers
top_10_producers <- result_df %>% 
  arrange(desc(Wheat_Production)) %>% 
  head(10)

# Calculate total N inputs and N losses (surplus)
top_10_producers$N_output <- top_10_producers$Wheat_Production * 0.02
top_10_producers$N_input <- top_10_producers$N_output / top_10_producers$NUE
top_10_producers$N_loss <- top_10_producers$N_input - top_10_producers$N_output

# Export the dataset as a CSV file
write.csv(top_10_producers, "output/top_10_wheat_producers.csv", row.names = FALSE)


### Create a bar plot of N outputs and losses
par(mar = c(5, 5, 1, 1))

# Separate data frames for N outputs and N losses
n_output_data <- data.frame(Country = top_10_producers$Country, N = top_10_producers$N_output, Legend = "N Output")
n_loss_data <- data.frame(Country = top_10_producers$Country, N = top_10_producers$N_loss, Legend = "N Loss")

# Combine the data frames
combined_data <- rbind(n_output_data, n_loss_data)

# Create a bar plot of N outputs and losses
ggplot(combined_data, aes(x = Country, y = N, fill = Legend)) +
  geom_col(width = 0.4, position = position_dodge(width = 0.8)) +
  labs(x = "Country", y = "Nitrogen (Mt)",
       title = "Nitrogen Output and Losses in Top 10 Wheat Producers") +
  scale_fill_manual(values = c("darkblue", "red"), labels = c("N Output", "N Loss")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Export the plot as a PDF file
export_path <- "output/top_10_wheat_producers_plot.pdf"
ggsave(export_path, plot = last_plot(), dpi = 700, device = "pdf")
dev.copy(pdf, export_path)
dev.off()

