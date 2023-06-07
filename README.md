# Contains information necessary for the completion of the technical test for the IIASA position “Researcher in integrated modeling of environmental impacts from land and water use” 

# 1. The global_wheat_production_map file is located in the output folder.
# 2. The csv file is locasted in the output folder.
# 3. The n_output_raster file is locasted in the output folder.
# 4a. The csv file is located in the output folder.
# 4b. The pdf file with the plotted data is located in the output folder.

# 4c. From the data available it can be deduced that the countries with a higher NUE ratio tend to have less pronounced nitrogen loss in absolute numbers. Developing economies, such as China, India, and Pakistan, have a higher nitrogen output; at the same time, these countries nitrogen exprience less  nitrogien loss relative to nitrogen output when compared to developed economies, such as Australia, France, USA, and Russia, where nitrogen loss (surplus) outpaces the nirogen imput. It can be a sign of intensivive agricultural practices used in developed economices which involve large-scale use of fertilizers.

# 5. The analysis performed can of great use to some elements of the BNR's suite. In particular, such analysis could be expanded using the EPIC-IIASA model for crop management analysis and bring new insights about the global nitrogen cycle disturbances at the national (and potentially regional) level. This approaches could also be translated to the GLOBIOM model to trace the effect of agriculture expansion and land conversion on nitrogen retention in the soil. The performed analysis could even inform nitrogen loss capping policy at the global scale, however, data obsolence and its low resolution should be highlighted as main limiting factors for further studies.


# 6.1 Due to the processing power limitations, aggregation above could not be performed neither on the working machine or the laternative machine. The task was completed
# using the national units taken from https://data.europa.eu/data/datasets/jrc-10112-10004?locale=en
# Running the task in QGIS on another machine (Acer Aspire V3-372, Intel Core i7-6500U, Windows 10) was successful, but the extraction of the resulting shapefule was corrupted due to invalid geometries. The QGIS project with the layer in question is located in GIS folder.
# However, with more processing power available, R code provided should be sufficient.
# QGIS Python command: processing.run("native:dissolve", {'INPUT':QgsProcessingFeatureSourceDefinition('C:\\Users\\Petr\\Documents\\GitHub\\IIASA\\data\\GAUL\\g2015_2005_2.shp', selectedFeaturesOnly=False, featureLimit=-1, flags=QgsProcessingFeatureSourceDefinition.FlagOverrideDefaultGeometryCheck, geometryCheck=QgsFeatureRequest.GeometryNoCheck),'FIELD':['ADM0_NAME'],'SEPARATE_DISJOINT':False,'OUTPUT':'TEMPORARY_OUTPUT'})
# NB! Root to be adjusted accordingly for QGIS command reproducibility 


# 6.2 In the NUE dataset, the country names were given in a shortened form and had to be changed manually to harmonise them with the wheat production dataset.


# 6.3 System specifications:
# Macbook Air 2020
# 1.1 GHz Dual-Core Intel Core i3
# Intel Iris Plus Graphics 1536 MB
# 8 GB 3733 MHz LPDDR4X
# Operational system: macOS Ventura 13.3.1

# Code reproduction
# With access to the public repository, the user will have to fetch the files and run the R code. All visualisation steps are explained there. It will be nesessary to add the data folder. Adding the GAUL0 folder to the data folder with the national units taken from https://data.europa.eu/data/datasets/jrc-10112-10004?locale=en might be necessary if there's a problem with computation of the hashed fragment of the code. 
