function err = get_bidirectional_error( X,Y )

[tmp,tmp,treeroot_y] = kdtree(Y,[]);
[idx_y] = kdtreeidx([],X,treeroot_y);

[tmp,tmp,treeroot_x] = kdtree(X,[]);
[idx_x] = kdtreeidx([],Y,treeroot_x);

match = 1:size(X,1);
idx_match = idx_x( idx_y );
idx_matched_y = find( (match' - idx_match) == 0 );

X_matched = X(idx_matched_y,:);

[tmp,tmp,treeroot_y] = kdtree(Y,[]);
idx = kdtreeidx([],X_matched,treeroot_y);
err = norm( X_matched - Y(idx,:) ) / size(idx,1);
