function [beta,CI,P] = ols(X,y)
%Do a least squate regression on the given data (variable X and target y)
%Outputs:
%   beta : beta obtained from the regression
%   CI   : confidence intervals for each component of beta (with 0.05 confidence level)
%   P    : p values attesting of the significane og each component of beta



n=size(X,1);
K=size(X,2);

beta=X'*X\X'*y;
y_hat=X*beta;

e=y-y_hat;


s2=e'*e/(n-K);

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
t_value=beta./SE;
%vector of p values
P=2*(1-tcdf(t_value,n-K));
end

