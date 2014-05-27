function [idx_mutual_x,point_mutual] = getMutualNeighbours( X,Y )
% GETMUTUALNEIGHBOURS Get Y indices that are mutual nearest neighbours
% of points in X.

point_mutual = [];
idx_mutual = [];
idx_mutual_x = [];
dist_mutual = [];
tree_y = kdtree_build(Y);
idx_y = ones(length(X),1);
idx_x = ones(length(Y),1);
dist_y = ones(length(X),1);
dist_x = ones(length(Y),1);
k = 1;
for i=1:length(X)
    [idx_y(i)] = kdtree_k_nearest_neighbors( tree_y, X(i,:), k );
end
tree_x = kdtree_build(X);
for i=1:length(Y)
    [idx_x(i)] = kdtree_k_nearest_neighbors( tree_x, Y(i,:), k );
end

for i=1:length(idx_y)
    idx = idx_y(i);
    if idx_x(idx) == i
        idx_mutual = [idx_mutual idx];
        point_mutual = [ point_mutual ; [Y(idx,:)] ];
        idx_mutual_x = [idx_mutual_x i];
    end
end

kdtree_delete( tree_y );
kdtree_delete( tree_x );

end

