function [stats] = compute_statistics(X,y,beta)
%Compute a set of statistics linked to a given model beta and vraibles X,y
%Outputs:
%beta               : initial beta
%sigma2             : empirical standard deviations of the error 
%var                : estimated variance of beta
%std_error          : standard error
%AIC                : AIC score 
%BIC                : BIC score
%R2                 : R2 score
%adj_R2             : adjusted R2 score 
%CI                 : confidence intervals of beta coeficients
%p_values           : p values of beta coeficients
%significant_test   : result of a significance test on beta coeficients  
%residuals          : residuals of the model predictions on y
%pred               :  model prediction on y

n=size(X,1);
K=size(X,2);
y_hat  = X*beta;
res    = y-y_hat ;
SSE    = res'*res;
SST    = sum((y-mean(y)).^2);

% compute scores
R2     = 1 - SSE/SST;
adj_R2 = 1 - (n-1)/(n-K) * (1-R2);
AIC = log(SSE / n) + 2 * K / n;
BIC = log(SSE / n) + log(n) * K / n;

% estimated variance 
s2  = SSE/(n-K);
var = s2*inv(X'*X);

% standart error estimator
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
% check is t_value is real, otherwise return Nan as p values
if isreal(t_value)
    P=2*(1-tcdf(abs(t_value),n-K));
end
[result]         = t_test(X,beta,SE);
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
stats.SSE        = SSE;
end


