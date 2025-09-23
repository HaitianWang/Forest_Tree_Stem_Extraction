function [treeTopRowId,treeTopColId] = helperDetectTreeTops(canopyModel,gridRes,minTreeHeight)

% Copyright 2021 The MathWorks, Inc.

% Compute crown Radius and variable window Radius
crownRadius = (1.2 + 0.16 * canopyModel)/2;
windowRadius = max(round(crownRadius/gridRes),1);

% Mark window radius as 0 for points with elevation less than minTreeHeight 
windowRadius(canopyModel < minTreeHeight) = 0;
uniqueWindowRadius = sort(unique(windowRadius),'descend');

% Initialize non-canopy points to true and tree tops to false
nonCanopyPoints = true(size(canopyModel));
treeTopPoints = false(size(canopyModel));

% Loop over each unique radius and detect tree tops
for i=1:length(uniqueWindowRadius)-1
    % Create structuring element
    r = double(uniqueWindowRadius(i));
    SE = bwdist(padarray(1,[r r]))<=r;
    SE(ceil(size(SE,1)/2),ceil(size(SE,2)/2)) = 0;
    % Identify tree top ids
    treeTopIds = canopyModel>=imdilate(canopyModel,SE) & windowRadius==r & nonCanopyPoints;
    nonCanopyPoints = nonCanopyPoints & ~(bwdist(treeTopIds)<=r);
    treeTopPoints = treeTopPoints|treeTopIds;
end

% Identify row and column ids of tree top points
[treeTopRowId,treeTopColId] = find(treeTopPoints);
end