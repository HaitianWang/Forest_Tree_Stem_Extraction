function [canopyCover, gapFraction, leafAreaIndex] = helperExtractForestMetrics(normalizedPoints, ...
    scanAngles, gridSize, cutoffHeight,leafAngDistribution)

% Copyright 2021 The MathWorks, Inc.

% Marks points with values less than cutoffHeight as ground
groundPtsIdx = normalizedPoints(:,3) < cutoffHeight;

% Identify 2D index for each 3D point
xmin = min(normalizedPoints(:,1));
xmax = max(normalizedPoints(:,1));
ymin = min(normalizedPoints(:,2));
ymax = max(normalizedPoints(:,2));
nrows = round((ymax - ymin)/gridSize) + 1;
ncols = round((xmax - xmin)/gridSize) + 1;
rowId = round((normalizedPoints(:,2) - ymin)/gridSize) + 1;
colId = round((normalizedPoints(:,1) - xmin)/gridSize) + 1;
ind = sub2ind([nrows, ncols], rowId, colId);
[sortedInd, ptInd] = sort(ind);

% Identify the number of points at each cell
idCounts = histc(ind, unique(ind)); %#ok<HISTC>

% Initialize canpoy cover, gap fraction and leaf area index
canopyCover = zeros(nrows, ncols);
gapFraction = zeros(nrows, ncols);
leafAreaIndex = zeros(nrows, ncols);
endIdx = 0;

% Loop over valid cells
for i = 1: length(idCounts)
    gridIdx = endIdx + 1;
    endIdx = endIdx + idCounts(i);
    classes = groundPtsIdx(ptInd(gridIdx:endIdx));
    vegPts = sum(~classes);
    % CC = numVegPoints/totalNumPoints
    canopyCover(sortedInd(gridIdx)) = vegPts/idCounts(i);
    % GF = numGroundPoints/totalNumPoints
    gapFraction(sortedInd(gridIdx)) = 1 - canopyCover(sortedInd(gridIdx));
    %LAI = -0.5*cos(meanScanAngle)*log(GF)
    meanAng = sum(scanAngles(ptInd(gridIdx:endIdx)))/idCounts(i);
    leafAreaIndex(sortedInd(gridIdx)) = -(cosd(meanAng)*log(gapFraction(sortedInd(gridIdx))))/leafAngDistribution;
end