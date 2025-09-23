Npoints = normalizedPoints;

for i=1:11

    clusterindex= find(label3D(:) == i);
    cluster = Npoints(clusterindex,:);
    figure
    pcshow(cluster)
end