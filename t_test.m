function [result] = t_test(X,y,param)
%PARAMETER_CI Summary of this function goes here
%   Detailed explanation goes here
n = size(X,1);
k = size(X,2);
%Covariance matrix estimator
y_hat  = X*param;
res    = y-y_hat;
SSE    = res'*res;
s2  = SSE/(n-k);
var = s2*inv(X'*X);
%standart error estimator
std_error  = sqrt(diag(var));
alpha  = 0.05;
t_crit = tinv(1-alpha/2,n-k);
t_val  = param./std_error;
significant_test = abs(t_val) > t_crit;
CI = [-t_crit*std_error + param,t_crit*std_error + param];

result=struct();
result.CI=CI;
result.t_val=t_val;
result.significant_test=significant_test;
end

