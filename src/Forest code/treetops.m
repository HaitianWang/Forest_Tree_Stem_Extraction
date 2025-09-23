% Set minTreeHeight to 5 m 
minTreeHeight = 5;
% Detect tree tops
[treeTopRowId,treeTopColId] = helperDetectTreeTops(canopyModel,gridRes,minTreeHeight);
% Visualize treetops
figure
imagesc(canopyModel)
hold on
plot(treeTopColId,treeTopRowId,"rx",MarkerSize=3)
title("CHM with Detected Tree Tops")
axis off
colormap("gray")