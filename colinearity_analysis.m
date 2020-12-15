function [s] = colinearity_analysis(X)
%Perform VIF analysis on the given matrix X.
%Outputs:
%VIF                  : VIF factors of the columns of X
%condition_number     : condition_number of X
%correlation_matrix   : correlation_matrix of the columns of X



% condition number
tX = X'*X;
[~,eig_val]  = eig(tX);
% correlation (without intercept)
corr = corrcoef(X(2:end,2:end));
condition_nb = abs(sqrt(max(diag(eig_val))/min(diag(eig_val))));
% Variance inflation factor : VIF_i = (1-R2_i)^{-1}
n   = size(X,1);
k   = size(X,2);
VIF = zeros(k,1);
% create VIF array, one variable at a time
for i = 2:k                              % do not consider intercept
    mask   = (1:k) ~= i;                 % all idx except i
    param = tX(mask,mask) \ tX(mask,i);  % regress i on all other variables
    SST = tX(i,i) - tX(1,i)^2 * (1/n);   % SST
    SSE = tX(i,i) - param'*tX(mask,i);   % SSE
    R2  = 1-SSE/SST;                     % R2
    VIF(i) = 1/(1-R2);                   % VIF
end

% save results
s = struct();
s.condition_number = condition_nb;
s.correlation_matrix = corr;
s.VIF = VIF;
end

