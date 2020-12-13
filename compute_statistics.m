function [stats] = compute_statistics(X,y,beta)

n=size(X,1);
K=size(X,2);

y_hat  = X*beta;
res    = y-y_hat ;
SSE    = res'*res;
SST    = sum((y-mean(y)).^2);
R2     = 1 - SSE/SST;
adj_R2 = 1 - (n-1)/(n-K) * (1-R2);
% estimated variance and stderr
s2  = SSE/(n-K);
AIC = log(SSE / n) + 2 * K / n;
BIC = log(SSE / n) + log(n) * K / n;
%Covariance matrix estimator
var=s2*inv(X'*X);

%standart error estimator
SE=sqrt(diag(var));

%confidence level
alpha=0.05;
%quantiles of the student distridution of degree n-K 
lower_quantile=tinv(alpha/2,n-K);
upper_quantile=tinv(1-alpha/2,n-K);
%confidence inteval of beta
CI=SE*[lower_quantile,upper_quantile]+beta;

%###testing H0 : nullity of each parameter in beta##%
%t statistic
t_value = beta./SE;
%vector of p values
P=NaN;
if isreal(t_value)
    P=2*(1-tcdf(t_value,n-K));
end
[result]         = t_test(X,y,beta);
significant_test = result.significant_test(end);

% Save all the computed results



stats = struct();
stats.beta       = beta;
stats.sigma2     = s2;
stats.sample_var = var;
stats.std_error  = SE;
stats.AIC        = AIC;
stats.BIC        = BIC;
stats.R2         = R2;
stats.adj_R2     = adj_R2;
stats.CI         = CI;
stats.p_values   = P;
stats.significant_test = significant_test;
stats.residuals  = res;
stats.pred       = y_hat;
end


