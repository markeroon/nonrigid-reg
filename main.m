% bundle adjustment
addpath( 'icp' );
addpath( 'file_management' );
addpath( genpath( 'vendor/coherent-point-drift' ) );

R =  [ 0.9101   -0.4080    0.0724 ;
       0.4118    0.8710   -0.2681 ;
       0.0463    0.2738    0.9607 ];
t = [ 63.3043,  234.5963, -46.8392 ];


n = 12;
scans=cell(n,1);
scans_rigid = cell(n,1);
scans_nonrigid = cell(n,1);
for q=1:n
    
filename = sprintf( '../../Data/PlantDataPly/plants_converted82-%03d-clean-clear.ply', q-1 );
[Elements_0,varargout_0] = plyread(filename);


X = [Elements_0.vertex.x';Elements_0.vertex.y';Elements_0.vertex.z']';
for j=1:q-1
        X_dash = R*X' + repmat(t,size(X,1),1)';
        X = X_dash';
end

idx = find( X(:,1) < -14 & X(:,2) < 290 & X(:,3) < 678 );
X = X( idx,:);
X = X(1:10:end,:);
scans{q} = X;
end

%%%%%%% SETUP WORK ON SUBSET -- BEGIN %%%%%%%%%%%%%
%scans = {scans{1} , scans{2}, scans{3}, scans{4}};
%scans = scans';
%n = 4;
%%%%%%% SETUP WORK ON SUBSET -- END %%%%%%%%%%%%%

opt.method = 'rigid'; %'nonrigid_lowrank';
opt.tol = 1e-12;
opt.viz = 1;
opt.fgt = 2;
opt.scale = 0;
% allow for reflections -> rot = 0
opt.rot = 0;
opt.normalize = 0;

%opt.numeig = 40;
%opt.eigfgt=1;

for j=1:5
    for i=1:n
        all_scans = build_allscans_matrix( i, scans );
        T = cpd_register(all_scans,scans{i},opt);
        scans{i} = T.Y;
    end
end

opt.method = 'nonrigid_lowrank';
opt.outliers = 0.6;
opt.lambda = 1;
opt.beta = 60;
opt.normalize = 1;
opt.max_it = 150;

outlier_vals = [ 0.7 0.6 0.5 0.4 0.3 0.3 0.4 0.5 0.6 0.6 0.7 0.7];
for j=1:12
    if j ~= 6
        opt.outliers = outlier_vals(j);
        T = cpd_register(scans{6},scans{j},opt);
        scans{j} = T.Y;
    end
end





