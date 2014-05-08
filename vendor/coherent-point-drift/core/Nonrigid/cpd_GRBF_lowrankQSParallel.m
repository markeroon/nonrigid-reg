function [Q,S]=cpd_GRBF_lowrankQSParallel(Y, beta, numeig, eigfgt, fgt);

[M,D]=size(Y);
hsigma=sqrt(2)*beta;

OPTS.issym=1;
OPTS.isreal=1;
OPTS.disp=1;

% if we do not use FGT we can construct affinity matrix G and find the
% first eigenvectors/values directly
if ~eigfgt
   tic;
   G=cpd_G(Y,Y,beta);
   [Q,S]=eigs(G,numeig,'lm',OPTS);
   save( 'savedfileQ','Q' );
   t1 = toc
   return; % stop here
   
end 

%%% FGT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if we use FGT than we can find eigenvectors without constructing G,
% all we need to give is the matrix vector product Gx, which can be
% implemented through FGT.

eps          = 8;      % Ratio of far field (default e = 10)
K          = round(min([sqrt(M) 100])); % Number of centers (default K = sqrt(Nx))
p          = 6;      % Order of truncation (default p = 8)

epsilon = 1e-6;  %10^(-e);
% we allow figtree to decide which method to use (4)
% on a non-uniform distribution (1)
evalMethod = 4; 
ifgtParamMethod = 1;
% with a max truncation 
ifgtTruncMethod = 1;
ifgtVerbose = 1;

%if( eigfgt == 1 && fgt < 3 )
    tic
    [Q,S]=eigs(@grbf_parfgt,M,numeig,'lm',OPTS);
    t3 = toc
%end

    function y=grbf_fgt(x,beta) % return y=Gx, without explicitelly constructing G
        [xc , A_k] = fgt_model(Y' , x', hsigma, eps,K,p);
        y = fgt_predict(Y' , xc , A_k , hsigma,eps);
    end

    function y=grbf_parfgt(x,beta)
        tic
        [xc , A_k] = fgt_model(Y' , x', hsigma, eps,K,p);
        ncores = 8;
        Y_all = cell(ncores,1);
        spacing = floor(size(Y,1) / ncores);
        lower=0;
        y_all = cell(ncores,1);
        for i=1:ncores
            Y_all{i} = Y(lower+1:lower+spacing,:);
            lower=lower+spacing;
        end
        
        parfor i=1:ncores
            y_all{i} = fgt_predict(Y_all{i}' , xc , A_k , hsigma,eps);
        end
        y = cell2mat(y_all');
        
        toc
        %tic
        %y2 = fgt_predict(Y' , xc , A_k , hsigma,eps);
        %toc
    end

    function y=grbf_ifgt(x,beta) % return y=Gx, without explicitelly constructing G
        evalMethod = 3; 
        ifgtParamMethod = 1;
        % with a max truncation 
        ifgtTruncMethod = 0;
        ifgtVerbose = 1;
        h = 0.7;
        
        y = figtree( ...
                Y', h, x', Y', ...
                epsilon, evalMethod ); %, ...
                %ifgtParamMethod, ...
                %ifgtTruncMethod, ifgtVerbose);
        y = y';
    end
disp('done')
end