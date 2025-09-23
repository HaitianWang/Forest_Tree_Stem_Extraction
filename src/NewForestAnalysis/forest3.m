clear all;
clc;
pathcan1 = "/home/ibrahim/Downloads/SegmentedTrees/";

writingpath1 = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/TreeCentrePlots/";
writingpath2 = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/TreeStatistics/";
files1 = dir(pathcan1);
plotnumber = 42;

for loop=3:96
    pathcanopy = pathcan1 +"/"+ files1(loop).name
    PCtls = lasdata(pathcanopy);
    PCtls = pointCloud(table2array(table(PCtls.x,PCtls.y,PCtls.z)));
    canopy  = PCtls.Location;
    TreeHeight = max(canopy(:,3));
    stem = canopy;
    num = files1(loop).name;
    num = split(num,'treeID');
    num = num(2);
    num = split(num,'.');
    Treenumber = str2num(string(num(1)))
    
    step = 0.2;
    i = 1;
    s = [];
    
    p1 = secCircle(stem(:,1:3),0.2,0.28);
    s1 = [i,plotnumber,Treenumber,TreeHeight,0.3,(p1(3) * 200),0,0];
    s = [s;s1];
    c1 =[];
    c2 = [];
    N = [];
    c1 =[c1;p1(1)];
    c2 =[c2;p1(2)];
     N = [N;0.3];
    i = i + 1;
    preradius = p1(3);
    n = 0;
    p2 = secCircle(stem(:,1:3),1.3,1.38);
    if p2(3) > p1(3)
         p2 = secCircle(stem(:,1:3),1.2,1.28);
    end

    if p2(3) > p1(3)
         p2 = secCircle(stem(:,1:3),1.1,1.18);
    end

%     if p2(3) > p1(3)
%          p2 = secCircle(stem(:,1:4),1.4,1.48);
%     end

    deltaX = (p2(1)-p1(1));
    deltaY = (p2(2)-p1(2));
    TreedeviationX = atand(deltaX);
    TreedeviationY = atand(deltaY);
    anglex = [];
 
    angley = [];
    
    s2 =[i,plotnumber,Treenumber,TreeHeight,1.3,(p2(3) * 200),TreedeviationX,TreedeviationY];
    s = [s;s2];
    i = i + 1;
    n = 0.2 ;
    
    higherpoint = n + 0.08;
    while n < (TreeHeight/2)
        if n >= (TreeHeight/2)
            break;
        end
          prep3 = secCircle(stem(:,1:3),n,higherpoint);
             n = n +step;
             higherpoint = n + 0.08;
        
         if n < TreeHeight
           
            p3 = secCircle(stem(:,1:3),n,higherpoint);
            
         end
        if p3(3) <= preradius
            deltaX = (p3(1)-prep3(1));
            deltaY = (p3(2)-prep3(2));
            TreedeviationX = atand(deltaX);
            TreedeviationY = atand(deltaY);
            s2 =[i,plotnumber,Treenumber,TreeHeight,n,(p3(3) * 200),TreedeviationX,TreedeviationY];
            angley =[angley;TreedeviationY];
            anglex =[anglex;TreedeviationX];
            c1 =[c1;p3(1)];
            c2 =[c2;p3(2)];
            s = [s;s2];
            N = [N;n];
            i = i + 1;
            preradius  = p3(3)
        end 
    end
     
     s2 =[i,plotnumber,Treenumber,TreeHeight,NaN,NaN,sum(anglex),sum(angley)];
     s = [s;s2];
    figure
    plot3(c1,c2,N,'-o','Color','b','MarkerSize',5,...
        'MarkerFaceColor','#D9FFFF')
    axis equal
    xlabel('Cx')
    ylabel('Cy')
    zlabel('Z')
    path11 = writingpath1 + string(Treenumber) + ".png";
    path22 = writingpath2 + string(Treenumber) + ".csv";
   
    ax = gca; 
%     ax.XTickMode = 'manual';
%     ax.YTickMode = 'manual';
    % ax.ZTickMode = 'manual';
    
    exportgraphics(ax,path11)
    % writematrix(s,path22);
    T = array2table(s);
    T.Properties.VariableNames(1:8) = {'Sno','PlotNo','TreeNo','Height','Section Length (m)','Diameter (cm)','X Deviation Angle','Y Deviation Angle'};
    writetable(T,path22)
end 