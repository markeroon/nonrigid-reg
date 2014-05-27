function [f_fixed_band,f_reach] = ...
    reachability_mex( kd_tree,X_vec,index,k )


dim = size( X_vec,2 );
if size(X_vec,1) < dim
    error( 'dims are wrong, input X_vec^T' )
end

[id] =  kdtree_k_nearest_neighbors( kd_tree, X_vec(index,:), k );
Y = X_vec(index,:);
X = X_vec(id,:);
dist_mahal = cvMahaldist(Y',X');

f_fixed_band = 0;
f_reach = 0;
for i=2:size(id,1) 
    [id_j] = kdtree_k_nearest_neighbors( kd_tree, X_vec(id(i),:), k );
    [dist_mahal_j] = cvMahaldist( X_vec(id(i),:)',X_vec(id_j,:)' );
    dist_mahal_k = max( dist_mahal_j );
    f_fixed_band = f_fixed_band + 1/((2*pi)^(dim/2)) * exp( -1 * (dist_mahal(1,i)^2) );
    f_reach = f_reach + 1/(2*pi)^(dim/2)*exp(-(max(dist_mahal(1,i),dist_mahal_k)^2) ); %/ (2*dist_mahal_j_n(n)^2) );
end

% 1/m
f_fixed_band = f_fixed_band / (size(id,1)-1);
f_reach = f_reach / (size(id,1)-1);

end