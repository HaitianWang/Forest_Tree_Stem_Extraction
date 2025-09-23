function filterData=ellipseDataFilter_RANSAC(data)
% Do ellipse scatter data filtering for ellipse fitting by RANSAC method.
% Author: Zhenyu Yuan
% Date: 2016/7/26
% Ref:  http://www.cnblogs.com/yingying0907/archive/2012/10/13/2722149.html
%       Extract RANSAC filtering in ellipsefit.m and make some modification
%% Parameter initialization
nSampLen = 3;               %%Set the number of points on which the model is based
nDataLen = size(data, 1);   %Data length
nIter = 50;                 %Maximum number of iterations
dThreshold = 2;             %threshold
nMaxInlyerCount=-1;         %Minimum points
A=zeros([2 1]);
B=zeros([2 1]);
P=zeros([2 1]);
%%  Main loop
for i = 1:nIter 
    ind = ceil(nDataLen .* rand(1, nSampLen)); %Sampling, select nSampLen different points
    %%  Build the model, store the coordinate points, the focal point and a point across the ellipse needed for modeling
    %Ellipse definition equation: the sum of the distances to two fixed points is constant
    A(:,1)=data(ind(1),:);    %focus
    B(:,1)=data(ind(2),:);    %focus
    P(:,1)=data(ind(3),:);    %Point on ellipse
    DIST=sqrt((P(1,1)-A(1,1)).^2+(P(2,1)-A(2,1)).^2)+sqrt((P(1,1)-B(1,1)).^2+(P(2,1)-B(2,1)).^2);
    xx=[];
    nCurInlyerCount=0;        %The number of initial points is 0
    %%  Does it fit the model?
    for k=1:nDataLen
        %         CurModel=[A(1,1)   A(2,1)  B(1,1)  B(2,1)  DIST ];
        pdist=sqrt((data(k,1)-A(1,1)).^2+(data(k,2)-A(2,1)).^2)+sqrt((data(k,1)-B(1,1)).^2+(data(k,2)-B(2,1)).^2);
        CurMask =(abs(DIST-pdist)< dThreshold);     %The point whose distance to the straight line is less than the threshold 
                                                    %conforms to the model and is marked as 1
        nCurInlyerCount =nCurInlyerCount+CurMask;             %Count the number of points conforming to the ellipse model
        if(CurMask==1)
            xx =[xx;data(k,:)];
        end
    end
    %% Choose the best model
    if nCurInlyerCount > nMaxInlyerCount   %The model with the most points that fits the model is the best model
        nMaxInlyerCount = nCurInlyerCount;
        %             Ellipse_mask = CurMask;
        %              Ellipse_model = CurModel;
        %              Ellipse_points = [A B P];
        filterData =xx;
    end
end