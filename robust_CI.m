function [SE, CI] = robust_CI(X,model)
% This function uses White?s heteroscedasticity consistent estimator to 
% produce robust heteroscedasticity estimators for beta
%
%confidence level alpha
alpha=0.05;
%sizes
n = size(X,1);
k = size(X,2);
%quantiles of the student distridution of degree n-K 
lower_quantile = tinv(alpha/2,n-k);
upper_quantile = tinv(1-alpha/2,n-k);
% variance of beta assuming heteroscedasticity
omega    = diag(model.residuals.^2);
tX       = inv(X'*X);
var_beta = tX * X'* omega * X * tX;
SE       = sqrt(diag(var_beta));
CI       = SE*[lower_quantile,upper_quantile]+model.beta;
end

