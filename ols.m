function [beta,statistics] = ols(X,y)
%OLS Summary of this function goes here
%   Detailed explanation goes here
beta = (X'*X) \ X'*y;
y_hat = X * beta;
statistics = stats(X,y,y_hat);
end

