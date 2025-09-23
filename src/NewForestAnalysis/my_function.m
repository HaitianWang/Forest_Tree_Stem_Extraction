
% ptCloud = pcread('final4.ply');
ptCloud = pointCloud(final4);

figure
pcshow(ptCloud);
% ptCloud.XLimits
ptCloud.Location();

%% Converting Point Cloud to 2D image
x = ptCloud.Location(:,1);
y = ptCloud.Location(:,2);
z = ptCloud.Location(:,3);
% dimx = ceil(abs(max(x)));
% dimy = ceil(abs(max(y)));

b1 = 0;
centre =0;
precir = 0;


if ptCloud.Count < 8200
dimx = 64;
dimy = 64;
else
dimx = 256;
dimy = 256;
end 
image2d = pointcloud2image(z,x,y,dimx,dimy);
% figure, imshow(image2d)

%%
% Morphological structuring element settings
structuring_type = 'disk';
structuring_size = 3;
% Setup structuring element (Rubric c.)
se = strel(structuring_type,structuring_size);

% Perform morphological oprations (closed & erode)  (Rubric e.)
im_cc = imerode(image2d,se);
% im_closed = imclose(im_cc,se);
BW = edge(im_cc,'canny'); % extract edges
%% Second way
% figure
% imshow(BW)

bw = imfill(BW,"holes");
minSize = 30;
bw = bwareaopen(bw,minSize);
se = strel("disk",2);
bw = imclose(bw,se);
bw = imfill(bw,"holes");
[B,L] = bwboundaries(bw,"noholes");
stats = regionprops(L,"Circularity","Centroid");

% imshow(label2rgb(L,@jet,[.5 .5 .5]))
% hold on

for k = 1:length(B)
    disp(length(B{k}))
    if length(B{k}) > precir
        precir =length(B{k});
%         if stats(k).Circularity >= b1
        boundary1 = B{k};
            b1 = stats(k).Circularity;
            maxcentre = stats(k).Centroid;

%          end
    end
end


% boundary1 = B{4};
%            
%             maxcentre = stats(4).Centroid;


sum = 0
for j= 1:length(boundary1)
    l = boundary1(j,:);
    X =[maxcentre(1),maxcentre(2);l(1),l(2)];
    d = pdist(X,'euclidean');
    sum = sum+d;
    %img(boundary1(j,:)) = L(boundary1(j,:));
end
xc = maxcentre(1);
yc = maxcentre(2);
xreal = ((xc/dimx)*(max(x)- min(x)))+ min(x);
yreal = ((yc/dimy)*(max(y)- min(y)))+ min(y);
radiusofcir = sum/length(boundary1);
radiuspcX = radiusofcir/dimx*(max(x)-min(x));
radiuspcY = radiusofcir/dimy*(max(y)-min(y));
disp([xreal,yreal])
disp([radiuspcX,radiuspcY])



[x1 y1x r]=circle_fit(x,y);

ptCloudOut = pcdenoise(ptCloud);

x2 = ptCloudOut.Location(:,1);

y2 = ptCloudOut.Location(:,2);

[x3 y3 r3]=circle_fit(x2,y2)
% 
% 


figure
imshow(label2rgb(L,@jet,[.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2),boundary(:,1),"w",LineWidth=2)
end
title("Objects with Boundaries in White")
stats = regionprops(L,"Circularity","Centroid");
threshold = 0.94;
for k = 1:length(B)
  % Obtain (X,Y) boundary coordinates corresponding to label "k"
  boundary = B{k};
  % Obtain the circularity corresponding to label "k"
  circ_value = stats(k).Circularity;
  % Display the results
  circ_string = sprintf("%2.2f",circ_value);
  % Mark objects above the threshold with a black circle
  if circ_value > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),"ko");
  end
  text(boundary(1,2)-35,boundary(1,1)+13,circ_string,Color="y",...
       FontSize=14,FontWeight="bold")
end
title("Centroids of Circular Objects and Circularity Values")







% ptCloud = pcread('final4.ply');
% figure
% pcshow(ptCloud);
% % ptCloud.XLimits
% ptCloud.Location()
% 
% %% Converting Point Cloud to 2D image
% x = ptCloud.Location(:,1);
% y = ptCloud.Location(:,2);
% z = ptCloud.Location(:,3);
% image2d = pointcloud2image(z,x,y,128,128);
% figure, imshow(image2d)
% 
% %%
% % Morphological structuring element settings
% structuring_type = 'disk';
% structuring_size = 3;
% % Setup structuring element (Rubric c.)
% se = strel(structuring_type,structuring_size);
% 
% % Perform morphological oprations (closed & erode)  (Rubric e.)
% im_cc = imerode(image2d,se);
% % im_closed = imclose(im_cc,se);
% BW = edge(im_cc,'canny'); % extract edges
% %% Second way
% % figure
% % imshow(BW)
% 
% bw = imfill(BW,"holes");
% minSize = 30;
% bw = bwareaopen(bw,minSize);
% se = strel("disk",2);
% bw = imclose(bw,se);
% bw = imfill(bw,"holes");
% 
% 
% [B,L] = bwboundaries(bw,"noholes");
% imshow(label2rgb(L,@jet,[.5 .5 .5]))
% hold on
% b1 = 0;
% 
% for k = 1:length(B)
%     disp(length(B{k}))
%     if length(B{k})> b1
%         boundary1 = B{k};
%             b1 = length(B{k});
% 
%     end
%   
%  end
% imshow(label2rgb(L,@jet,[.5 .5 .5]))
% hold on
% for k = 1:length(B)
%   boundary = B{k};
%   plot(boundary(:,2),boundary(:,1),"w",LineWidth=2)
% end
% title("Objects with Boundaries in White")
% 
% 
% 
% 
% 
% stats = regionprops(L,"Circularity","Centroid");
% 
% threshold = 0.94;
% 
% 
% for k = 1:length(B)
% 
%   % Obtain (X,Y) boundary coordinates corresponding to label "k"
%   boundary = B{k};
%   
%   % Obtain the circularity corresponding to label "k"
%   circ_value = stats(k).Circularity;
%   
%   % Display the results
%   circ_string = sprintf("%2.2f",circ_value);
% 
%   % Mark objects above the threshold with a black circle
%   if circ_value > threshold
%     centroid = stats(k).Centroid;
%     plot(centroid(1),centroid(2),"ko");
%   end
%   
%   text(boundary(1,2)-35,boundary(1,1)+13,circ_string,Color="y",...
%        FontSize=14,FontWeight="bold")
%   
% end
% title("Centroids of Circular Objects and Circularity Values")
% img = ones(60,60);
% sum = 0
% for j= 1:length(boundary1)
%     l = boundary1(i,:);
%     X =[c2(1),c2(2);l(1),l(2)];
%     d = pdist(X,'euclidean');
%     sum = sum+d;
%     %img(boundary1(j,:)) = L(boundary1(j,:));
% end
% figure
% imshow(img)
% title("Inner circle")
% 
% % [x1 y1 r]=circle_fit(x,y)
% % 
% % ptCloudOut = pcdenoise(ptCloud)
% % 
% % x2 = ptCloudOut.Location(:,1);
% % 
% % y2 = ptCloudOut.Location(:,2);
% % 
% % [x3 y3 r3]=circle_fit(x2,y2)
% % 
% % 
