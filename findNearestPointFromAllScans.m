function [ dist ] = findNearestPointFromAllScans( scans, scan_idx )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    X = scans{scan_idx};
    scans{scan_idx} = [];
    idx_y = zeros( size(scans{scan_idx},1),1);
    dist = zeros( size(idx_y) );
    Y = cell2mat( scans );
    tree_y = kdtree_build(Y);
    k = 1;
    for i=1:size(X,1)
        [idx_y(i),dist(i)] = kdtree_k_nearest_neighbors( tree_y, X(i,:), k );
    end
end

