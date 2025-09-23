% Segment individual trees
label2D = helperSegmentTrees(canopyModel,treeTopRowId,treeTopColId,minTreeHeight);
% Identify row and column id of each point in label2D and transfer labels
% to each point
rowId = ceil((ptCloud.Location(:,2) - ptCloud.YLimits(1))/gridRes) + 1;
colId = ceil((ptCloud.Location(:,1) - ptCloud.XLimits(1))/gridRes) + 1;
ind = sub2ind(size(label2D),rowId,colId);
label3D = label2D(ind);
% Extract valid labels and corresponding points
validSegIds = label3D ~= 0;
ptVeg = select(ptCloud,validSegIds);
veglabel3D = label3D(validSegIds);
% Assign color to each label
numColors = max(veglabel3D);
colorMap = randi([0 255],numColors,3)/255;
labelColors = label2rgb(veglabel3D,colorMap,OutputFormat="triplets");
% Visualize tree segments
figure
pcshow(ptVeg.Location,labelColors)
title("Individual Tree Segments")
view(2)