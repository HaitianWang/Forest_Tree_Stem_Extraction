

writingpath = "/media/ibrahim/9cfd0642-7019-4875-9519-d9bd91f84711/FORESTDATARESULTS23/file42/";
ptclassified = ptVeg ;
treelabels = veglabel3D ;
treeloc = ptclassified.Location;
labels = unique(treelabels);
colrs = labelColors;
lastlabel = max(labels);
for x=1:82
    newindex = find(treelabels(:)==x);
    [a,b] = size(newindex);
    if a<5000
        continue
    end
    newtree = treeloc(newindex,:);
    filename = writingpath + "treeID"+ string(x)+".ply";
    treecolor = colrs(newindex,:);
    treept = pointCloud(newtree);
    treept.Color = treecolor;
    pcwrite(treept,filename,'Encoding','binary');
end