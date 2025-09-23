% clc;
% clear all;
treepath = "/home/ibrahim/Desktop/FilteredForestTrees/tree4.ply";
treetest = pcread(treepath);
treeloc16 = treetest.Location;
TreeHeight = abs(max(treeloc16(:,3)) -min(treeloc16(:,3)))


% figure
% pcshow(treetest)

[final1,p1,c1] = circeprocessing2(treeloc16,0.5,0.6);
disp(p1)
disp(c1)

% figure
% pcshow(final1)


[final2,p2,c2]= circeprocessing(treeloc16,1.3,1.4,p1(7));
% 
% figure
% pcshow(final2)
disp(p2)
disp(c2)

[final3,p3,c3]= circeprocessing(treeloc16,2.2,2.3,p2(7));
% 
% figure
% pcshow(final3)
disp(p3)
disp(c3)

[final4,p4,c4]= circeprocessing(treeloc16,3.2,3.3,p3(7));
% 
% figure
% pcshow(final4)
disp(p4)
disp(c4)



[final5,p5,c5]= circeprocessing(treeloc16,5.2,5.3,p4(7));

% figure
% pcshow(final5)
disp(p5)
disp(c5)


[final6,p6,c6]= circeprocessing(treeloc16,7.0,7.1,p5(7));

% figure
% pcshow(final6)
disp(p6)
disp(c6)

[final7,p7,c7]= circeprocessing(treeloc16,9.0,9.1,p6(7));

% figure
% pcshow(final7)
disp(p7)
disp(c7)



% treepath = "/home/ibrahim/Desktop/FilteredForestTrees/tree4.ply";
% treetest = pcread(treepath);
% treeloc16 = treetest.Location;
% TreeHeight = max(treeloc16(:,3))
% 
% 
% figure
% pcshow(treetest)
% 
% [final1,centerLoc1,Re1] = circeprocessing2(treeloc16,0.5,0.6);
% disp(Re1)
% 
% figure
% pcshow(final1)
% 
% 
% [final2,centerLoc2,Re2]= circeprocessing(treeloc16,1.2,1.3,centerLoc1,Re1);
% 
% figure
% pcshow(final2)
% disp(Re2)
% 
% [final3,centerLoc3,Re3]= circeprocessing(treeloc16,2.2,2.4,centerLoc2,Re2);
% 
% figure
% pcshow(final3)
% disp(Re3)
% 
% [final4,centerLoc4,Re4]= circeprocessing(treeloc16,3.2,3.4,centerLoc3,Re3);
% 
% figure
% pcshow(final4)
% disp(Re4)
% 
% 
% 
% [final5,centerLoc5,Re5]= circeprocessing(treeloc16,5.2,5.4,centerLoc4,Re4);
% 
% figure
% pcshow(final5)
% disp(Re5)
% 
% 
% [final6,centerLoc6,Re6]= circeprocessing(treeloc16,7.0,7.2,centerLoc5,Re5);
% 
% figure
% pcshow(final6)
% disp(Re6)
% 
% [final7,centerLoc7,Re7]= circeprocessing(treeloc16,9.0,9.2,centerLoc6,Re6);
% 
% figure
% pcshow(final7)
% disp(Re7)






% 
% treeindex16 = find(treeloc16(:,3)<0.9);
% processedtree16 = treeloc16(treeindex16,:);
% treeindex16 = find(processedtree16(:,3)>0.7);
% processedtree16 = processedtree16(treeindex16,:);
% ptCloud16 = pointCloud(processedtree16);
% [centerLoc1,a1,Re1 ] = circFit3D(processedtree16);
% disk_locations2=sqrt((processedtree16(:,1)-centerLoc1(1)).^2+(processedtree16(:,2)-centerLoc1(2)).^2);
% sampleIndices1 = find(disk_locations2(:)<=2*Re1);
% 
% 
% processedtree166 = processedtree16(sampleIndices1,:);
% 
% processedtree166 = pcdenoise(pointCloud(processedtree166));
% 
% processedtreeloc = processedtree166.Location;
% 
% 
% minDistance = 0.08;
% minPoints = 100;
% [labels16,numClusters16] = pcsegdist((processedtree166),minDistance,'NumClusterPoints',minPoints);
% maxlen = 0;
% 
% for k=1:numClusters16
%     ind16 = find(labels16(:)==k);
%     if length(ind16) >maxlen
%         final16 =processedtreeloc(ind16,:);
%         maxlen =length(ind16);
%     end
% 
% end

% 
% figure
% pcshow(processedtreeloc)




% stem2 = processedtree16;
% stem2(:,1:2) = processedtree16(:,1:2);
% stem2(:,3) = 0;
% 
% 
% figure
% pcshow(stem2)