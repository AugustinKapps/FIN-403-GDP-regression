function [BP_stat,BP_crit,H] = Breusch_Pagan_test(Z,res,alpha)
%Perform breusch pagan test on the the given data W, resudials res at a
%confidence level alpha.
%Outputs:
%   BP_stat   : breusch pagan statistic
%   BP_crit   : critical value for the given confidence level
%   H         : resulting hypothesis, 1 if the null hypothesis
%   (homooscedasticity) is rejected


%Z = [ones(n,1) Z]  %add bias to Z
n = size(Z,1);
p = size(Z,2);

g = (res.^2/((res'*res)/n))-1;
gamma = (Z'*Z)\(Z'*g) ;  %fit the gammas
g_hat = Z*gamma;         %prediction for g

% under H_0 => 1/2 * g_hat'*g is chi2 in p
BP_stat = 1/2 * (g_hat'*g_hat);
BP_crit = chi2inv(1-alpha,p);
% perform the test
if BP_stat > BP_crit
   H = 1;
else 
   H = 0;
end
end

