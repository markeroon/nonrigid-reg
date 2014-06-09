% bundle adjustment

addpath( './lib/file_management' );
addpath( genpath( 'vendor/coherent-point-drift' ) );
addpath('vendor/kdtree/lib' )
addpath('vendor/kdtree-mex/' );
addpath('vendor/mahalanobis/' );
addpath('lib/anisotropic_filter/');

R =  [ 0.9101   -0.4080    0.0724 ;
       0.4118    0.8710   -0.2681 ;
       0.0463    0.2738    0.9607 ];
t = [ 63.3043,  234.5963, -46.8392 ];

% stop and restart parallel pool
delete(gcp)
parpool('LocalProfile1')

n = 12;
scans=cell(n,1);
scans_sampled=cell(n,1);
scans_rigid = cell(n,1);
scans_nonrigid = cell(n,1);
for q=1:n
    
filename = sprintf( '~/Data/PlantDataPly/plants_converted82-%03d-clean-clear.ply', q-1 );
[Elements_0,varargout_0] = plyread(filename);


X = [Elements_0.vertex.x';Elements_0.vertex.y';Elements_0.vertex.z']';

for j=1:q-1
        X_dash = R*X' + repmat(t,size(X,1),1)';
        X = X_dash';
end

scans_sampled{q} = X(1:20:end,:);
scans{q} = scans_sampled{q};
end


opt.viz = 1;
opt.scale = 0;
% allow for reflections -> rot = 0
opt.rot = 0;
opt.method = 'rigid';
opt.outliers = 0.1;
opt.lambda = 2;%1;
opt.beta = 8;%90;
opt.normalize = 1;
opt.max_it = 40;
opt.tol = 1e-10;
opt.fgt = 2;
opt.eigfgt = 1;
opt.numeig = 100;%floor( size(scans{1},1) / 300 );


for i=1:3
    T = cpd_register( scans{12}, scans{1}, opt );
    scans{1} = T.Y;
    % rigid pre-alignment
    for j=1:11
        T = cpd_register( scans{j},scans{j+1},opt );
        scans{j+1} = T.Y;
    end
end
scans_save = scans;

opt.method = 'nonrigid_lowrank';
opt.normalize = 1;
for i=1:60
    for j=1:12
        sprintf( 'outer loop #%d, scan #%d', [i j])
        scans_c = getMutualNeighbourCentroids( scans, j );
        T = cpd_register(scans_c,scans{j},opt);
        scans{j} = T.Y;
        %[cp,dist,treeroot_y] = kdtree(scans{j+1},scans{j});
        %tree_y = kdtree_build(Y);
        %[idx_y(i)] = kdtree_k_nearest_neighbors( tree_y, X(i,:), k );
    end
end