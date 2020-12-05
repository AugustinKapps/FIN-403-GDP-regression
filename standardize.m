function [result] = standardize(X)
%STANDARDIZE Summary of this function goes here
%   Detailed explanation goes here

%ommit the intercept
cols = 2:size(X,2);
X(:,cols) = (X(:,cols)- mean(X(:,cols)))./std(X(:,cols));

result=X;
end

