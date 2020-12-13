function [model] = ols(X,y)
%Do a least squate regression on the given data (variable X and target y)
%Outputs:
%   beta : beta obtained from the regression
%   CI   : confidence intervals for each component of beta (with 0.05 confidence level)
%   P    : p values attesting of the significane og each component of beta

beta  = (X'*X)\(X'*y);
model = compute_statistics(X,y,beta);
end

