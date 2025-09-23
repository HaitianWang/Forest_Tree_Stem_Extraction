groundPoints = groundPtCloud.Location;
% Eliminate duplicate points along x- and y-axes
[uniqueZ,uniqueXY] = groupsummary(groundPoints(:,3),groundPoints(:,1:2),@mean);
uniqueXY = [uniqueXY{:}];
% Create interpolant and use it to estimate ground elevation at each point
F = scatteredInterpolant(double(uniqueXY),double(uniqueZ),"natural");
estElevation = F(double(ptCloud.Location(:,1)),double(ptCloud.Location(:,2)));
% Normalize elevation by ground
normalizedPoints = ptCloud.Location;
normalizedPoints(:,3) = normalizedPoints(:,3) - estElevation;
% Visualize normalized points
figure
pcshow(normalizedPoints)
title("Point Cloud with Normalized Elevation")