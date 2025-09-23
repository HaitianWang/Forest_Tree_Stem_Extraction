function   [Cparameter,AvCenter] = cylinderfit(points)
maxDistance = 0.1;
referenceVector = [0 0 1];

[model,inlierIndices] = pcfitcylinder((points),maxDistance,referenceVector);
loc = points.Location;

% figure
% pcshow(loc(inlierIndices,:));

Cparameter = model.Parameters;
AvCenter = model.Center;
