function [idx_mutual_x,point_mutual,Y_mutual] = getMutualNeighbours( X,Y )
% GETMUTUALNEIGHBOURS Get Y indices that are mutual nearest neighbours
% of points in X. If no mutual nearest neighbour exists, vector will
% [inf inf inf]

point_mutual = [];
idx_mutual_x = [];
tree_y = kdtree_build(Y);
idx_y = ones(length(X),1);
idx_x = ones(length(Y),1);
Y_mutual = zeros(size(X)) .* inf;
k = 1;
for i=1:size(X,1)
    [idx_y(i)] = kdtree_k_nearest_neighbors( tree_y, X(i,:), k );
end
tree_x = kdtree_build(X);
for i=1:size(Y,1)
    [idx_x(i)] = kdtree_k_nearest_neighbors( tree_x, Y(i,:), k );
end

for i=1:length(idx_y)
    if idx_x(idx_y(i)) == i
        point_mutual = [ point_mutual ; [Y(idx_y(i),:)] ];
        idx_mutual_x = [idx_mutual_x i];
        Y_mutual(i,:) = Y(idx_y(i),:);
        
    end
end

kdtree_delete( tree_y );
kdtree_delete( tree_x );

end

