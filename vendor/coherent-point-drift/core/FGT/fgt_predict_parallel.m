function [Kt1] = fgt_predict_parallel(X , xc , A_k , hsigma,e )

ncores = 8;
X_cell = cell(ncores,1);
spacing = floor(size(X,1) / ncores);
lower=0;
Kt1_cell = cell(ncores,1);
for i=1:ncores
    if i~=ncores
        X_cell{i} = X(lower+1:lower+spacing,:);
        lower=lower+spacing;
    else
        X_cell{i} = X(lower+1:end,:);
    end
end
%Kt1 = fgt_predict(X' , xc , A_k , hsigma,e);
parfor i=1:ncores
    Kt1_cell{i} = fgt_predict(X_cell{i}' , xc , A_k , hsigma,e);
end
Kt1 = cell2mat(Kt1_cell');

end