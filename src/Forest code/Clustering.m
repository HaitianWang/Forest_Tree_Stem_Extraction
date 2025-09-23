minDistance = 0.3;
minPoints = 30;
[labels,numClusters] = pcsegdist(nonGroundPtCloud,minDistance,'NumClusterPoints',minPoints);

idxValidPoints = find(labels);
labelColorIndex = labels(idxValidPoints);
segmentedPtCloud = select(nonGroundPtCloud,idxValidPoints);

figure
colormap(hsv(numClusters))
pcshow(segmentedPtCloud.Location,labelColorIndex)
title('Point Cloud Clusters')