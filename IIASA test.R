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
export_path <- "output/wheat_production_map.tif"

# Export the raster as a GeoTIFF file
writeRaster(wheat_production_raster, export_path, format = "GTiff")

###Produce a global map
install.packages(c("rasterVis"))
library(rasterVis)

# Read the wheat production raster
wheat_production_raster <- raster("output/wheat_production_map.tif")

# Set up the plot parameters
par(mar = c(0, 0, 0, 0))
plot(wheat_production_raster, col = rev(terrain.colors(10)), main = "Global Wheat Production (Mt)")

# Add a color legend with a name
levelplot(wheat_production_raster, col.regions = rev(terrain.colors(10)),
          scales = list(draw = TRUE),
          orientation = "horizontal",
          par.settings = list(axis.line = list(col = NA)))

# Export the plot as a PDF file
export_path <- "output/global_wheat_production_map.png"
ggsave(export_path, plot = last_plot(), device = "png")
dev.copy(png, export_path)
dev.off()


###Task 2
library(rgdal)
library(sp)

# Set the path to the GAUL shapefile
gaul_path <- "data/GAUL/g2015_2005_2.shp"

# Read the GAUL shapefile
gaul_shapefile <- readOGR(gaul_path)

# Aggregate polygons by country
gaul_aggregated <- aggregate(gaul_shapefile, by = "ADM0_NAME")

# Aggregate wheat production to country level
wheat_production_country <- raster::extract(wheat_production_raster, gaul_aggregated, fun = sum, na.rm = TRUE)

# Create a data frame with country names and production values
production_df <- data.frame(Country = gaul_aggregated$ADM0_NAME, Wheat_Production = wheat_production_country)

# Set the path to export the CSV file
export_path <- "output/wheat_production_country.csv"

# Export the data frame as a CSV file
write.csv(production_df, export_path, row.names = FALSE)