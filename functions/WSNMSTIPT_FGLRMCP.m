function [tenB, tenT,change] = WSNMSTIPT_FGLRMCP(tenD, lambda, mu,C,p)
% Solve the WSNM problem 
% ---------------------------------------------
% Input:
%       tenD       -    n1*n2*n3 tensor
%       lambda  -    >0, parameter
%       mu-      regelarization parameter
%       p    -    key parameter of Schattern p norm
%
% Output:
%       tenB       -    n1*n2*n3 tensor
%       tenT       -    n1*n2*n3 tensor
%       change     -    change of objective function value
%% initialize
max_iter = 500;
normD = norm(tenD(:));
preTnnT= 0;
NOChange_counter = 0;
change=zeros(1,max_iter);
[M, N, p] = size(tenD);
MS = M;MC = N;MB = 1;stepsize  = 1;stepsizeb  = 1;
image2d = hsiTo2d (tenD,MS,MC,MB,stepsize,stepsizeb);
[q,o]=size(image2d);
L  = FGLR_graph(image2d); 
%% %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
tmpY = image2d;
tmpYX = zeros(q,o);tmpT = zeros(q,o);
weightTenT = ones(size(tmpYX)) ;
rho = 0.0027;%0.0027
tol=1e-6; max_rho1 = 1e6; rho1 = 1.5;%1.5
iter = 0; 
maxit = 4; %4
while iter<maxit
    iter = iter + 1;
    %% X subproblem
    eye_lenX = eye(o);
    temp = rho * (tmpY-tmpT)+tmpYX;
    tmpX=((rho*eye_lenX+2*L)\ temp')';
    X = R2dTohsi(tmpX,tenD,MS,MC,MB,stepsize,stepsizeb);
    L = FGLR_graph(tmpX);
    %% --------------------- MCP ----------------------------------
     r1 =4.5; %0.5
     r2 =1;%0.5
     tau = 1e-6;
     Sk = tmpT;
     H  = correcH(Sk,r1,r2);         %% double
     Stemp = (lambda*H + tau*Sk + tmpYX + rho*tmpY - rho*tmpX)/(rho + tau);  %% rho是可调参数
     DoubleStemp = double(Stemp);
     tmpT  = softthre(DoubleStemp,weightTenT*lambda/(rho + tau));
     weightTenT = 1 ./ (abs(tmpT) + 0.01);
     T = R2dTohsi(tmpT,tenD,MS,MC,MB,stepsize,stepsizeb);
    %%
    leq1 = image2d - tmpX - tmpT;
    tmpYX = tmpYX + rho * leq1;
    rho  = min(max_rho1,rho*rho1);
    %% chg+tubalrank %%运行使用
    stopCriterion = norm(tenD(:) - X(:) - T(:)) / normD;
change(iter)=(stopCriterion);
    currTnnT=tubalrank(T,0);
if currTnnT == preTnnT
    NOChange_counter=NOChange_counter +1;
else
    NOChange_counter = 0;
end
 if (stopCriterion < tol) || (NOChange_counter >=1)
    break;
end             
    preTnnT = currTnnT; 
    disp(['#Iteration ' num2str(iter) ' trankT ' ...
        num2str(currTnnT) ...
        ' stopCriterion ' num2str(stopCriterion) ]);
end
tenB = X;
tenT=T;
end