function [F_stat, F_crit, H] = FTest(X,y,R,q,alpha)
% Perform F test on the given data X,y usgin the given constraints R,q at
% confidence level alpha
%Outputs:
%F_stat : F statistic
%F_crit : critical value at confidence level alpha
%H : 1 of we reject H0 0 otherwise. H0 beiing the hypothesis that the
%constraints are true

% sizes
n = size(X,1);
k = size(X,2);
J = size(R,1);

%OLS estimator
model_ols = ols(X,y);
param     = model_ols.beta;
asym_var  = model_ols.sample_var;

% compute F statistic
error = (R * param - q);
F_stat = error' * inv(R * asym_var * R') * error / J;
% compute critical value at confidence level alpha
F_crit = finv(1-alpha,J,n-k);

% perform the test and compute the hypothesis
if F_stat > F_crit
    H = 1;
else
    H = 0;
end

end