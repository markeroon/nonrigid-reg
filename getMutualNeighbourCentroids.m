function [ Y_c ] = getMutualNeighbourCentroids( scans, cell_idx )
%GETMUTUALNEIGHBOURCENTROIDS Summary of this function goes here
%   Detailed explanation goes here

points = cell(12,1);
Y_nearest = cell(12,1);
idx_nearest_x = cell(12,1);
%dist_nearest_y = cell(12,1);
map = cell(12,1);
for i=1:12
    if cell_idx ~= i
        [idx_nearest_x{i},points{i},Y_nearest{i}] = getMutualNeighbours( ...
            scans{cell_idx}, scans{i} );
    end
end

Y_c = [];
for j=1:size(scans{cell_idx},1)
    Y_c = [Y_c ; [getCentroidOfPointsAt( Y_nearest, j )]];
end

end

