function [beta,R2] = ols(X,y)
%OLS Summary of this function goes here
%   Detailed explanation goes here
n = size(X,1);
k = size(X,2);
beta = (X'*X) \ X'*y;
y_hat = X * beta;
R2 = stats(y,y_hat);
end

