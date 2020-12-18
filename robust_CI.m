function [CI] = robust_CI(X,model)
% This function uses White?s heteroscedasticity consistent estimator to 
% produce robust heteroscedasticity estimators for beta
%

%sizes
n=size(X,1);
K=size(X,2);
%confidence level
alpha=0.05;
%quantiles of the student distridution of degree n-K 
lower_quantile=tinv(alpha/2,n-K);
upper_quantile=tinv(1-alpha/2,n-K);
% variance of beta assuming heteroscedasticity
omega    = diag(model.residuals);
var_beta = inv(X'*X)* X'*omega*X* inv(X'*X);

CI=diag(var_beta)*[lower_quantile,upper_quantile]+model.beta;
end

