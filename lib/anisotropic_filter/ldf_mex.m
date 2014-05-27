function ldf = ldf_mex( tree_kd,X_vec,index,k,f_reach )
    
idx = kdtree_k_nearest_neighbors( tree_kd,X_vec(index,:),50);
ldf = 1. / (sum(f_reach(idx) / k));

end