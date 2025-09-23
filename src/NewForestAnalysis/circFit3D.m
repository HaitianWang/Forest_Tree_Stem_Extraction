function [centerLoc, circleNormal, radius] = circFit3D(circLocs)
% extends circFit() to provide the best fit for a circle in R3.
% circLocs nx3: x, y, z coordinates
meanLoc = mean(circLocs);
numCurPts = length(circLocs);
movedToOrigin = circLocs - ones(numCurPts, 1)*meanLoc;
% plot3(curLocs(:, 2), curLocs (:, 3), curLocs (:, 4)); grid on;
% xlabel('x'); ylabel('y'); zlabel('z');
[U, s, V]= svd(movedToOrigin);
circleNormal = V(:, 3);
circleLocsXY = rodriguesRotation(movedToOrigin, circleNormal, [0, 0, 1]);
[xc, yc, radius] = Circfit(circleLocsXY(:, 1), circleLocsXY(:, 2));
centerLoc = [xc, yc, 0] + meanLoc;
end