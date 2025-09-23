points = final3;


subplot(2, 1, 1);
plot(points(:,1), points(:,2), 'b.');
grid on;
axis equal;
title('Input Data');
% Make into NumPoints-by-2 tall array.
data = [points(:,1), points(:,2)];

filterData = EllipseDataFilter_RANSAC(data);
% Plot results:
subplot(2, 1, 2);
plot(filterData(:, 1), filterData(:, 2), 'r-');
grid on;
title('Fitted Data');
