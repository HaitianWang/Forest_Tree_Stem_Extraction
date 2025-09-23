function   [final,p,c] = circeprocessing(treeloc16,lowTh,HightTH, Pr)

    treeindex16 = find(treeloc16(:,3)<HightTH);
    processedtree16 = treeloc16(treeindex16,:);
    treeindex16 = find(processedtree16(:,3)>lowTh);
    processedtree16 = processedtree16(treeindex16,:);
    ptCloud16 = pointCloud(processedtree16);
    [centerLoc1,a1,Re1 ] = circFit3D(processedtree16);
    
    disk_locations2=sqrt((processedtree16(:,1)-centerLoc1(1)).^2+(processedtree16(:,2)-centerLoc1(2)).^2);
    sampleIndices1 = find(disk_locations2(:)<2*Re1);
    
    processedtree166 = processedtree16(sampleIndices1,:);
        

    
    processedtree166 = pcdenoise(pointCloud(processedtree166));
    
    processedtreeloc = processedtree166.Location;

    
    
    
    minDistance = 0.08;
    minPoints = 100;
    [labels16,numClusters16] = pcsegdist((processedtree166),minDistance,'NumClusterPoints',minPoints);
    maxlen = 0;
    
    for k=1:numClusters16
        ind16 = find(labels16(:)==k);
        if length(ind16) >maxlen
            final =processedtreeloc(ind16,:);
            maxlen =length(ind16);
            
        end
    
    end

    
   
    [centerLoc2,a2,Re2 ] = circFit3D(final);

     if Pr< Re2

         [labels16,numClusters16] = pcsegdist(pointCloud(final),minDistance,'NumClusterPoints',minPoints);
    maxlen = 0;
    
    for k=1:numClusters16
        ind16 = find(labels16(:)==k);
        if length(ind16) >maxlen
            final =final(ind16,:);
            maxlen =length(ind16);
            
        end
    
    end
   

     end

     figure
    pcshow(final)

%      indices = findPointsInCylinder(pointCloud(final),Pr);
        
%      pt = [min(final(:,1)),min(final(:,2)), min(final(:,3)) ];
% 
%      [indices,dists] = findNeighborsInRadius(pointCloud(final),mean(final),Pr);
%      final = final(indices,:);
%      figure
%      pcshow(final)

%      center = mean(final);
% dist = vecnorm(final-center,2,2);
% [a,b] =histcounts(dist);

% threshold = b(find(a(:) == max(a)));

% threshold = (max(a)/2);
% 
% 
% ind = find(dist<= threshold);
% newpoint = final(ind,:);

      [p,c] = cylinderfit(pointCloud(final));

%     if Pr< Re2
%     [indices,dists] = findNeighborsInRadius(pointCloud(final),centerLoc2,Pr);
%     final  = final(indices,:);
% %     final1 = pcdenoise(pointCloud(final));
% %     final = final1.Location;
%     [centerLoc2,a2,Re2 ] = circFit3D(final);
% 
%     end



