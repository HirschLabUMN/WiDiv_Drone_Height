## MATLAB Scripts Readme

AvgPHTwGroundBins.m is the MATLAB script used for plant height extraction using 97th percentile as top of plant and 3rd percentile as ground value. Formatted as a function with date and planting (.shp file plot bounding boxes - WIDIV) as inputs. 

AvgPHTwGroundBins_allplotvalues.m is a slightly variable version of AvgPHTwGroundBins.m that exports all DEM values rather than an averaged plant height using 97th minus 3rd percentile. Formatted as a function with date and planting (.shp file GCP bounding boxes - GCP) as inputs. Used to extract heights of GCPs since they are too small to be accurately extracted using AvgPHTGroundBins.m.

PHT_PlotSubset.m is referenced within AvgPHTwGroundBins.m and AvgPHTwGroundBins_allplotvalues.m and is never used independently. This script creates a mask and clips the geotiff to the roi of the plot.

Using_AvgPHTGroundBins.m and Using_AvgPHTGroundBins_allplotvalues.m are scripts used to run the functions AvgPHTGroundBins.m and AvgPHTwGroundBins_allplotvalues.m for each date of interest. 