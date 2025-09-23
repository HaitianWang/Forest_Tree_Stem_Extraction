function treeMetrics = helperExtractTreeMetrics(normalizedPoints,label3D)

% Copyright 2021 The MathWorks, Inc.

% Consider points belongs to valid labels
validLabels = label3D ~= 0;
filteredLabels = label3D(validLabels);
filteredPoints = normalizedPoints(validLabels,:);
[filteredLabels, sortedIds] = sort(filteredLabels);
filteredPoints = filteredPoints(sortedIds,:);

% Identify the number of points at each cell
uniqueLabels = unique(filteredLabels);
idCounts = histc(filteredLabels, uniqueLabels); %#ok<HISTC>

% Create treeMetrics table
treeMetrics = table('Size', [length(idCounts),7], ...
            'VariableTypes', {'uint32', 'uint32', 'double', 'double', 'double', 'double', 'double'}, ...
            'VariableNames',{'TreeId', 'NumPoints', 'TreeApexLocX', 'TreeApexLocY','TreeHeight','CrownDiameter','CrownArea'});

endIdx = 0;
% Loop over valid cells
for i = 1: length(idCounts)
    gridIdx = endIdx + 1;
    endIdx = endIdx + idCounts(i);
    treeMetrics.TreeId(i) = i;
    treeMetrics.NumPoints(i) = idCounts(i);
    [~,id]= max(filteredPoints(gridIdx:endIdx,3));
    treeMetrics.TreeApexLocX(i) = filteredPoints(gridIdx+id-1,1);
    treeMetrics.TreeApexLocY(i) = filteredPoints(gridIdx+id-1,2);
    treeMetrics.TreeHeight(i) = filteredPoints(gridIdx+id-1,3);
    if(idCounts(i) >=3)
        [~, treeMetrics.CrownArea(i)] = convhull(double(filteredPoints(gridIdx:endIdx,1:2)));
    else
        treeMetrics.CrownArea(i) = 0;
    end
end
treeMetrics.CrownDiameter = 2 * sqrt(treeMetrics.CrownArea/ pi);