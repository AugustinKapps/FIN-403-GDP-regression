function [result] = t_test(X,y,param)
%PARAMETER_CI Summary of this function goes here
%   Detailed explanation goes here
n = size(X,1);
k = size(X,2);
statistics = stats(X,y,X*param);
std_error=statistics.SE;
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

