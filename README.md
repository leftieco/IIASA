# Contains code and data files necessary for the completion of the technical test for the IIASA position “Researcher in integrated modeling of environmental impacts from land and water use” 
# 4c.
# 5.
# 6.1 Due to the processing power limitations, aggregation above could not be performed neither on the working machine or the laternative machine. The task was completed
# using the national units taken from https://data.europa.eu/data/datasets/jrc-10112-10004?locale=en
# Running the task in QGIS on another machine (Acer Aspire V3-372, Intel Core i7-6500U, Windows 10) was successful, but the extraction of the resulting shapefule was corrupted due to invalid geometries. The QGIS project with the layer in question is located in GIS folder.
# However, with more processing power available, R code provided should be sufficient.
# QGIS Python command: processing.run("native:dissolve", {'INPUT':QgsProcessingFeatureSourceDefinition('C:\\Users\\Petr\\Documents\\GitHub\\IIASA\\data\\GAUL\\g2015_2005_2.shp', selectedFeaturesOnly=False, featureLimit=-1, flags=QgsProcessingFeatureSourceDefinition.FlagOverrideDefaultGeometryCheck, geometryCheck=QgsFeatureRequest.GeometryNoCheck),'FIELD':['ADM2_CODE','ADM2_NAME','STR2_YEAR','EXP2_YEAR','ADM1_CODE','ADM1_NAME','STATUS','DISP_AREA','ADM0_CODE','Shape_Leng','Shape_Area'],'SEPARATE_DISJOINT':False,'OUTPUT':'TEMPORARY_OUTPUT'})
# 6.2 In the NUE dataset, the country names were given in a shortened form and had to be changed manually to harmonise them with the wheat production dataset.
# 6.3 System specifications:
# Macbook Air 2020
# 1.1 GHz Dual-Core Intel Core i3
# Intel Iris Plus Graphics 1536 MB
# 8 GB 3733 MHz LPDDR4X
# Operational system: macOS Ventura 13.3.1
