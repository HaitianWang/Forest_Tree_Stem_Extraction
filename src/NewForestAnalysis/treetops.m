% Set minTreeHeight to 5 m 
minTreeHeight = 1;
% Detect tree tops
gridRes = 0.5;
[treeTopRowId,treeTopColId] = helperDetectTreeTops(canopyModel,gridRes,minTreeHeight);
% Visualize treetops
figure
imagesc(canopyModel)
hold on
plot(treeTopColId,treeTopRowId,"rx",MarkerSize=3)
title("CHM with Detected Tree Tops")
axis off
colormap("gray")
