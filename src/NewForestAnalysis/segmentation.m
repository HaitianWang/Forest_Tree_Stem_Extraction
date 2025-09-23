
groundPtsIdx16 = segmentGroundSMRF(pointCloud(processedtree166));
nonGroundPtCloud16 = select(pointCloud(processedtree166),~groundPtsIdx16);
groundPtCloud16 = select(pointCloud(processedtree166),groundPtsIdx16);
% Visualize non-ground and ground points in magenta and green, respectively
figure
pcshow(nonGroundPtCloud16)
title("Segmented Non-Ground and Ground Points")