clear all;
clc;
pathcan1 = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/dFPCBZ25_03_Output_laz1_4_clipped/pointclouds/canopy";
pathstem1 = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/dFPCBZ25_03_Output_laz1_4_clipped/pointclouds/stem";
writingpath2 = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/dFPCBZ25_03_Output_laz1_4_clipped/";
keySet2 = {1,2,3,4,5,6,7,8,9,10, ...
 11,12,13,14,15,16,17,18,...
19,20,21,22,23,24,25,26,27,28,29,30,31,32};
    valueSet2 = { [255 0 0] [255 204 204] [178 102 255]  [128 128 128]  [128 0 0] [0 191 255] ...
        [255 0 255] [0 255 0]  [124 252 0] [175 255 36] [255 255 255] [255 99 71]...
       [255 255 0] [85 107 47] [0 255 255] [255 20 147] [135 206 250] [255 215 0] ...
       [255 140 0] [0 139 139] [128 15 242] [242 157 188] [102 230 255] [240 223 206] ...
       [243 255 79] [0 115 76] [255 102 178] [150 150 150] ...
       [255 102 255] [229 204 255] [255 182 193],[204 153 255]};

colorselection2 = containers.Map(keySet2,valueSet2);



dataFolder = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/dFPCBZ25_03_Output_laz1_4_clipped/";
dataFile = dataFolder + "FPCBZ25_03_Output_laz1_4_clipped.las";   
lasReader = lasFileReader(dataFile);
% Read point cloud along with corresponding scan angle information
[ptCloud,pointAttributes] = readPointCloud(lasReader,"Attributes","ScanAngle");
% Visualize the input point cloud

loc = ptCloud.Location;
colorloc = uint8(zeros(ptCloud.Count,3));

h = figure;
pcshow(ptCloud.Location)
title("Input Point Cloud")




files1 = dir(pathcan1);
files2 = dir(pathstem1);
plotnumber = 31;


for loop=3:31
    pathcanopy = pathcan1 +"/"+ files1(loop).name
    pathstem = pathstem1  +"/"+ files2(loop).name
    stem = readmatrix(pathstem);
    Treenumber = stem(1,4);
    canopy  = readmatrix(pathcanopy);
    TreeHeight = max(canopy(:,3));
    stemheight = max(stem(:,3));
    Treestem1 = canopy(:,1:3);
    Treestem = [Treestem1;stem(:,1:3)];
    ind = find(Treestem(:,3) ==TreeHeight );
    point = Treestem(ind,:);
    
    [Idx, D] = knnsearch(loc,Treestem);

    Treestem = loc(Idx,:);

%     Treestem = pointCloud(Treestem);
%     color = uint8(zeros(Treestem.Count,3));

    colr = colorselection2(Treenumber);
    colorloc(Idx,1) = colr(1); 
    colorloc(Idx,2) = colr(2); 
    colorloc(Idx,3) = colr(3); 
   
%     
%     hold on
%     pcshow(Treestem)
%     labels = "tree no :"+string(Treenumber);  
%     text(point(1),point(2),string(Treenumber),'Color','white','FontSize',14)

  

%     figure
%     plot3(c1,c2,N,'-o','Color','b','MarkerSize',5,...
%         'MarkerFaceColor','#D9FFFF')
%     axis equal
%     xlabel('Cx')
%     ylabel('Cy')
%     zlabel('Z')
%     path11 = writingpath1 + string(Treenumber) + ".png";
%     path22 = writingpath2 + string(Treenumber) + ".csv";
%    
%     ax = gca; 
% %     ax.XTickMode = 'manual';
% %     ax.YTickMode = 'manual';
%     % ax.ZTickMode = 'manual';
%     
%     exportgraphics(ax,path11)
%     % writematrix(s,path22);
%     T = array2table(s);
%     T.Properties.VariableNames(1:8) = {'Sno','PlotNo','TreeNo','Height','Section Length (m)','Diameter (cm)','X Deviation Angle','Y Deviation Angle'};
%     writetable(T,path22)
end 

ptCloud.Color = colorloc;
path11 = writingpath2 + string(31) + ".ply";
pcwrite(ptCloud,path11,'Encoding','binary');


%     path11 = writingpath2 + string(31);
%     ax = gca; 
%     Figure2xhtml(path11,h)

%     fig2u3d(ax, path11)
%     exportgraphics(ax,path11)