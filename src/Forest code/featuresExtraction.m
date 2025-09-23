% Set grid size to 10 meters per pixel and cutOffHeight to 2 meters
gridSize = 0.1;
cutOffHeight = 2;
leafAngDistribution = 0.5;
% Extract forest metrics
[canopyCover,gapFraction,leafAreaIndex] = helperExtractForestMetrics(normalizedPoints, ...
    pointAttributes.ScanAngle,gridSize,cutOffHeight,leafAngDistribution);
% Visualize forest metrics
hForestMetrics = figure;
axCC = subplot(2,2,1,Parent=hForestMetrics);
axCC.Position = [0.05 0.51 0.4 0.4];
imagesc(canopyCover,Parent=axCC)
title(axCC,"Canopy Cover")
axis off
colormap(gray)
axGF = subplot(2,2,2,Parent=hForestMetrics);
axGF.Position = [0.55 0.51 0.4 0.4];
imagesc(gapFraction,'Parent',axGF)
title(axGF,"Gap Fraction")
axis off
colormap(gray)
axLAI = subplot(2,2,[3 4],Parent=hForestMetrics);
axLAI.Position = [0.3 0.02 0.4 0.4];
imagesc(leafAreaIndex,Parent=axLAI)
title(axLAI,"Leaf Area Index")
axis off
colormap(gray)