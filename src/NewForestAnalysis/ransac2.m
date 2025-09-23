

% [P, inlierIdx] = fitPolynomialRANSAC(final(:,1:2),2,10);
% pcshow(final4(inlierIdx,:))
pcshow(final5)
pcwrite(pointCloud(final5),'final5','PLYFormat','binary');
