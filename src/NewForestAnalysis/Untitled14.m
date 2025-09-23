treepath = "/home/ibrahim/Desktop/FilteredForestTrees/tree16.ply";
treetest = pcread(treepath);
treeloc16 = treetest.Location;

figure
pcshow(treetest)

treeindex16 = find(treeloc16(:,3)<1);

processedtree16 = treeloc16(treeindex16,:);

treeindex16 = find(processedtree16(:,3)>0.7);

processedtree16 = processedtree16(treeindex16,:);
ptCloud16 = pointCloud(processedtree16);



minDistance = 0.3;
minPoints = 100;
[labels16,numClusters16] = pcsegdist(treetest,minDistance,'NumClusterPoints',minPoints);
maxlen = 0;

for k=1:numClusters16
    ind16 = find(labels16(:)==k);
    if length(ind16) >maxlen
        final16 =treeloc16(ind16,:);
        maxlen =length(ind16);
    end

end


figure
pcshow(final16)