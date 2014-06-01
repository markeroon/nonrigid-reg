function [ X_c ] = getCentroidOfPointsAt( Y_mutual, index )
%GETCENTROIDOFPOINTSAT Find centroid of n points of dimension d.
% Points of the form [nan nan nan] are not to be included.
% Y_mutual is a cell containing multiple n x d sets of points
    Y_mutual_vec = [];
    for c=2:size( Y_mutual,1 )
        if isempty(Y_mutual_vec)
            Y_mutual_vec = Y_mutual{c}(index,:);
        else
            Y_mutual_vec = [Y_mutual_vec ;[Y_mutual{c}(index,:)]];
        end
    end
    X_c = getCentroidOfPoints( Y_mutual_vec );
    index
end

function [X_c] = getCentroidOfPoints( X_all )
%GETCENTROIDOFPOINTS Find centroid of n points of dimension d.
% Points of the form [nan nan nan] are not to be included.
% X_all is a n x d set of points
    X_c = zeros(size(1,size(X_all,2)));
    count = 0;
    sum = zeros(1,size(X_all,2));
    for i=1:size(X_all,1)
        if( ~isnan(X_all(i,1)) )
            sum = sum + X_all(i,:);
            count = count+1;
        end
    end
    if count > 0
        X_c = sum ./ count;
    else
        X_c = [];
    end
end

