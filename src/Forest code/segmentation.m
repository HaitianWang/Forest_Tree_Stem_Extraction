
% Segment Ground and extract non-ground and ground points
groundPtsIdx = segmentGroundSMRF(ptCloud);
nonGroundPtCloud = select(ptCloud,~groundPtsIdx);
groundPtCloud = select(ptCloud,groundPtsIdx);
% Visualize non-ground and ground points in magenta and green, respectively
figure
pcshowpair(nonGroundPtCloud,groundPtCloud)
title("Segmented Non-Ground and Ground Points")