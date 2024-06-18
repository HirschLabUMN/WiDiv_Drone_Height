%Getting Average Plant Height per Plot Estimates 
% 1. Extracting Plots from DEM (each row separately)
% 2. Binning Plot to get all height points for 20 bins
% 3. Extracting all values from DEM and export in multiple files


function [grid, means, variance, min_g] = AvgPHTwGroundBins_allplotvalues (date, planting)
%date = '07232021lessGCP';
%planting = 'GCP';

file = strcat('QGIS_Layers/', date, '/', date, '_geotiffDEM', '.tif');
[DEM] = geotiffread(file(:,:,1)); %// type uint8
DEM = im2double(DEM(:,:,1));
shapefile = strcat('QGIS_Layers/', date, '/Plots_', planting,'.shp');
roi = shaperead(shapefile);
%mapshow(roi);

clearvars shapefile

bins = 20;

R = geotiffinfo(file); 
[x,y] = pixcenters(R); 
[X,Y] = meshgrid(x,y); % Convert x,y arrays to grid: 

clearvars R x y 

grid = zeros(length(roi), bins);
grid_g = zeros(length(roi), bins);
min_g = zeros(length(roi), 1);
means = zeros(length(roi), 1);
means_g = zeros(length(roi), 1);
variance = zeros(length(roi), 1);

%% Extracting plot
for plot = 1:length(roi)
    [DEMplot] = PHT_PlotSubset (DEM, roi, plot, X, Y); % Extracting plot
    
    % Divide plot into grid
    M = bins + 1 ; N = bins + 1 ; %subsetting in the x direction 21 points equidistant; not subsetting in y or z direction
    rows = length(DEMplot(:,1));
    columns = length(DEMplot(1,:));
    x2 = linspace(1, columns , M);
    y2 = linspace(1, rows, N) ;
    
    [X2,Y2] = meshgrid(x2,y2);
    
    % Extracting ground height
    for j = 1:M -1 % Get pc for each grid box (roi) into structure array
        A = [X2(1,j) Y2(1,j)] ;
        B = [X2(1,j+1) Y2(1,j+1)] ;
        
        xmin = A(1);
        ymin = 1;
        xmax = B(1);
        ymax = rows;
        zmin = 0;
        zmax = inf;
        
        leftColumn = xmin;
        rightColumn = xmax;
        topLine = ymin;
        bottomLine = ymax;
        width = rightColumn - leftColumn;
        height = bottomLine - topLine;
        DEMplot_bin = imcrop(DEMplot, [leftColumn, topLine, width, height]);
        
        % export all pixel values
        path = 'Data_Analysis/Height/';
        writematrix( DEMplot_bin, strcat(path, 'All_Pixels/', planting, '/', 'All_pixels_', date, '_', planting, '_', num2str(plot), '_', num2str(j), '.txt'), 'Delimiter', 'tab');
        
        grid_g(plot, j) =  prctile(DEMplot_bin(:,1), 3); %3rd percentile
        
    end
        min_g(plot, 1) = nanmin(grid_g(plot,:));
        
    % Extracting average plot height
    for j = 1:M -1
        A = [X2(1,j) Y2(1,j)] ;
        B = [X2(1,j+1) Y2(1,j+1)] ;
        
        xmin = A(1);
        ymin = 1;
        xmax = B(1);
        ymax = rows;
        zmin = 0;
        zmax = inf;
        
        leftColumn = xmin;
        rightColumn = xmax;
        topLine = ymin;
        bottomLine = ymax;
        width = rightColumn - leftColumn;
        height = bottomLine - topLine;
        
        DEMdiff = DEMplot - (min_g(plot, 1));
        DEMdiff_bin = imcrop(DEMdiff, [leftColumn, topLine, width, height]);
        
        DEMplot_sub = DEMdiff_bin(DEMdiff_bin > 0);
        grid(plot, j) =  (prctile(DEMplot_sub(:,1), 97))*100;
        means(plot, 1) = (trimmean(grid(plot,5:16), 16));
        variance(plot, 1) = var((grid(plot,5:16))); 
        
    end
    
    clearvars x2 y2 X2 Y2 DEMplot DEMplot_bin grid_g j A B DEMplot_sub DEMdiff_bin 

end

%% Export data

path = 'Data_Analysis/Height/';
writematrix( grid, strcat(path, 'Grids/', planting, '/', '97min3_', date, '_', planting, '.txt'), 'Delimiter', 'tab');
writematrix( means, strcat(path, 'Means/', planting, '/97min3Mean_', date, '_', planting, '.txt'), 'Delimiter', 'tab');
writematrix( variance, strcat(path, 'Variance/', planting, '/97min3Var_', date, '_', planting, '.txt'), 'Delimiter', 'tab');
writematrix( min_g, strcat(path, 'GroundMin/min3_', date, '_', planting, '.txt'), 'Delimiter', 'tab');

end
