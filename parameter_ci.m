function [CI,t_val,significant_test] = parameter_ci(X,y,param)
%PARAMETER_CI Summary of this function goes here
%   Detailed explanation goes here
n = size(X,1);
k = size(X,2);
[~,~,~,~,std_error] = stats(X,y,X*param);
alpha  = 0.05;
t_crit = tinv(1-alpha/2,n-k);
t_val  = param./std_error;
significant_test = abs(t_val) > t_crit;
CI = [-t_crit*std_error + param,t_crit*std_error + param] 
end

