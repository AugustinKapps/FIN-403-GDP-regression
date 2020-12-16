function [result] = t_test(X,param,std_error)
% Perform a t test on the coeficient of the given vector of parameters param.
% Outputs:
%   CI : confidence intervals of all the parameters
%   t_val : t statistic
%   significant_test : results of the t test 1 if we reject the null
%   hypothesis (a coefficient being null)

n = size(X,1);
k = size(X,2);

% confidence level
alpha  = 0.05;
% critical value
t_crit = tinv(1-alpha/2,n-k);
% t statistic
t_val  = param./std_error;
% t test
significant_test = abs(t_val) > t_crit;
% confidence intervals
CI = [-t_crit*std_error + param,t_crit*std_error + param];

% save the results
result=struct();
result.CI=CI;
result.t_val=t_val;
result.significant_test=significant_test;
end

