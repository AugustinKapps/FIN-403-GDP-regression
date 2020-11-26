function [R2,adj_R2,sigma2,sample_var,std_error] = stats(X,y,y_hat)
%STATS Summary of this function goes here
n = length(y);
k = size(X,2);
% R2 and Adj R2
res = y_hat - y;
SSE = res'*res;
SST = sum((y-mean(y)).^2);
R2  = 1 - SSE/SST;
adj_R2 = 1 - (n-1)/(n-k) * (1-R2);
% estimated variance and stderr
sigma2     = SSE/(n-k);
sample_var = sigma2 * inv(X'*X);
std_error  = sqrt(diag(sample_var));
end

