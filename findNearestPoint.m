function [ dist ] = findNearestPoint( X,Y  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    idx_y = zeros( size(X,1),1);
    dist =  zeros( size(X,1),1);
    tree_y = kdtree_build(Y);
    k = 1;
    for i=1:size(X,1)
        [idx_y(i),dist(i)] = kdtree_k_nearest_neighbors( tree_y, X(i,:), k );
    end
end

