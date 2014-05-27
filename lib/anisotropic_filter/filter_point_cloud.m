function [f] = filter_point_cloud( X,Y )
    kd_tree = 
    dim = size( X_vec,2 );
    if size(X_vec,1) < dim
        error( 'dims are wrong, input X_vec^T' )
    end
    for i=1:size( X,1 )
        [id] =  kdtree_k_nearest_neighbors( kd_tree, X_vec(index,:), k );
        id = kNearestNeighbours( 
        d = 
    end


end