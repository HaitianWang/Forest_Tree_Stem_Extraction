function label2D = helperSegmentTrees(canopyModel,treeTopRowId,treeTopColId,minTreeHeight)

% Copyright 2021 The MathWorks, Inc.

% Generate marker image 
markerImage = false(size(canopyModel));
vaildTreeTops = sub2ind(size(canopyModel),treeTopRowId,treeTopColId);
markerImage(vaildTreeTops) = true;

% Filter complement of CHM by minima imposition
canopyComplement = -canopyModel;
minImage = imimposemin(canopyComplement, markerImage);
label2D = watershed(minImage, 8);

% Remove labels for points with value less than minTreeHeight
label2D(canopyModel < minTreeHeight) = 0;

% Regroup labels
label2D = bwlabel(label2D ~= 0, 8);
end