## README file for all raw data

1. Folders 2018, 2019, 2020, and 2021 each contain the following data from their respective years:
	- folder Data_Analysis/Height - contains all exported data ]
		- exported final heights for plots are found in /Means/WIDIV 
		- exported values for the GCPs are within /All_Pixels/GCP
	- folder Data_Analysis/Plot_Order contains: 
		- the outputted Roi files from MATLAB with the GPS coordinates of the plot boundaries ('boundary'_Matlab_Roi_'year'.csv) 
		- the names of the plots listed in chronological order (Plots_only_WIDIV.csv)
		- the names of the plots listed in the export order and the order they are listed in the Data_Analysis/Height/Means/WIDIV/.txt files (Plots_WIDIV.txt)
	- folder GCP_coordinates_'field name'_'year'_ contains:
		- the GCP coordinates - sometimes multiple if GCPs were not in the same location each flight
		- 2019-2021 contain a map of the locations of the GCPs
		- 2020-2021 contain screenshots of the swift console used to collect GCP locations
	- folder manual_measurements contains manual plant height measurements for specific plots
	- weather data for the location including
		- Precipitation_'year'.csv
		- Temperature_Data_StPaul_'year'.csv
		- Weather_'year'.csv
	- stand count data StandCount_StPaul_'year'.csv

2. Folder All contains data that is the same for all years:
	- All_Year_Canopy_Loess_Data.csv - a .csv file containing all of the canopy cover data 
	- B73v4.gene_function.txt - the version 4 B73 functional annotation 
	- FloweringTimeHeteroticGroup_Widiv.csv - a .csv file containing the Genotype, days to flowering, and heterotic group for each genotype in the analysis
	- IterationsForPValue.txt - GDD and year iterations used in some analyses
	- MaizeChromosomes.csv - lengths of each maize chromosome
	- Plots2GenotypeAllYears.csv - the genotype present in each plot for each year
	- All_Widiv_Genotypes.csv - all genotypes currently in the Wisconsin diversity panel.
  - Our_Widiv_Genotypes.csv - the subset of genotypes from the Wisconsin diversity panel that were used in this study.