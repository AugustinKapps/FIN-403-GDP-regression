function [result_tr,result_te] = standardize(X_tr,X_te)
%STANDARDIZE Summary of this function goes here
%   Detailed explanation goes here

%ommit the intercept
cols = 2:size(X_tr,2);
m    = mean(X_tr(:,cols));
std_ =  std(X_tr(:,cols));
X_tr(:,cols) = (X_tr(:,cols)- m)./std_;
X_te(:,cols) = (X_te(:,cols)- m)./std_;
result_tr=X_tr;
result_te=X_te;
end

