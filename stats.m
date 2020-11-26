function [R2] = stats(y,y_hat)
%STATS Summary of this function goes here
%   Detailed explanation goes here
res = y_hat - y;
RSS = res'*res;
SST = sum((y-mean(y)).^2);
R2  = 1 - RSS/SST;
end

