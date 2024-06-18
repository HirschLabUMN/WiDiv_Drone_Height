%%%% Subsetting Geottif image to desired ROI
% file = field orthomosaic file
% shapefile = plot subset shapefile
% plot = plot number

function [DEMplot] = PHT_PlotSubset (DEM, roi, plot, X, Y)


% Remove trailing nan from shapefile
rx = roi(plot).X(1:end-1);
ry = roi(plot).Y(1:end-1);

% Create Mask
mask_area = inpolygon(X,Y,rx,ry); 

clearvars rx ry;

%% Apply mask to orthomosaic
DEMplot = bsxfun(@times, DEM, mask_area);

% Get coordinates of the boundary of the freehand drawn region.
structBoundaries = bwboundaries(mask_area);
x = structBoundaries{1}(:, 2); % Columns of n by 2 array of x,y coordinates
y = structBoundaries{1}(:, 1); % Rows of n by 2 array of x,y coordinates

clearvars mask_area structBoundaries;

% Now crop the image.
leftColumn = min(x);
rightColumn = max(x);
topLine = min(y);
bottomLine = max(y);
width = rightColumn - leftColumn;
height = bottomLine - topLine;
DEMplot = imcrop(DEMplot, [leftColumn, topLine, width, height]);


