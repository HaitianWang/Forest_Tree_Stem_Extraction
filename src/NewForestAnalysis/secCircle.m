function   Par = secCircle(treeloc16,lowTh,HightTH)

    treeindex16 = find(treeloc16(:,3)<HightTH);
    processedtree16 = treeloc16(treeindex16,:);
    treeindex16 = find(processedtree16(:,3)>lowTh);
    processedtree16 = processedtree16(treeindex16,:);
    ptCloud16 = pointCloud(processedtree16);
    Par = CircleFitByTaubin(processedtree16(:,1:2));
    
%     disk_locations2=sqrt((processedtree16(:,1)-centerLoc1(1)).^2+(processedtree16(:,2)-centerLoc1(2)).^2);
%     sampleIndices1 = find(disk_locations2(:)<2*Re1);
%     
%     processedtree166 = processedtree16(sampleIndices1,:);
%         
% 
%     
%     processedtree166 = pcdenoise(pointCloud(processedtree166));
%     
%     processedtreeloc = processedtree166.Location;
% 
%     