function [F_stat, F_crit, H] = FTest(X,y,R,q,alpha)
% Perform F test on the given data X,y usgin the given constraints R,q at
% confidence level alpha
%Outputs:
%F_stat : F statistic
%F_crit : critical value at confidence level alpha
%H : 1 of we reject H0 0 otherwise. H0 beiing the hypothesis that the
%constraints are true

%OLS parameters
param = (X'*X)\(X'*y);

%different sizes
n = size(X,1);
K = size(X,2);
J = size(R,1);

% estimate the variance
res = y - X * param;
e_sq = res'*res;
asym_var = e_sq / (n-K) * inv(X'*X);

% compute F statistic
F_stat = (R * param - q)' * inv(R * asym_var * R') * (R * param - q) / J;
% compute critical value at confidence level alpha
F_crit = finv(1-alpha,J,n-K);

% perform the test and compute the hypothesis
if F_stat > F_crit
    H = 1;
else
    H = 0;
end

end
