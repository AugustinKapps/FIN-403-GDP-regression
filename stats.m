function [stats] = stats(X,y,y_hat)
%STATS Summary of this function goes here
n = length(y);
k = size(X,2);
% R2 and Adj R2
res = y-y_hat;
SSE = res'*res;
SST = sum((y-mean(y)).^2);
R2  = 1 - SSE/SST;
adj_R2 = 1 - (n-1)/(n-k) * (1-R2);
% estimated variance and stderr
sigma2     = SSE/(n-k);
sample_var = sigma2 * inv(X'*X);
std_error  = sqrt(diag(sample_var));
AIC = log(SSE / n) + 2 * k / n;
BIC = log(SSE / n) + log(n) * k / n;

stats=struct();
stats.sigma2=sigma2;
stats.sample_var=sample_var;
stats.std_error=std_error;
stats.AIC=AIC;
stats.BIC=BIC;
stats.R2=R2;
stats.adj_R2=adj_R2;
stats.SE=std_error;
stats.residuals=res;


end

