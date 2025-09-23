
maxDistance = 0.005;
referenceVector = [0 0 1];
% points = pcread('final4.ply');
% points =pointCloud(final4);
ptc = pcread('final4.ply');
points = ptc.Location;
figure
pcshow(points)

center = mean(points);
dist = vecnorm(points-center,2,2);

figure
histogram(dist)

dist2 = vecnorm(points-center,2,1);

figure
histogram(dist2)


% Look at the distribution of the distance
[a,b] =histcounts(dist);

threshold = b(find(a(:) == max(a)));

ind = find(dist<= threshold);
newpoint = points(ind,:);

figure
pcshow(newpoint)
% 
% [model,inlierIndices] = pcfitcylinder((points),maxDistance,referenceVector);
% figure
% plot(model)
% pc2 = select(points,inlierIndices);
% figure
% pcshow(pc2)
% title("Cylinder Point Cloud")