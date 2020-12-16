function [result_tr,result_te] = standardize(X_tr,X_te)
%standardize the given imputs. Note that for consitency reason : the test set X_te will be rescaled
%using the mean and varicance of the test set X_tr
%Outputs:
%   result_tr : normalized train set
%   result_te : normalized test set


%  ommit the intercept
cols = 2:size(X_tr,2);
% compute ths statistics
m    = mean(X_tr(:,cols));
std_ =  std(X_tr(:,cols));
% rescale
X_tr(:,cols) = (X_tr(:,cols)- m)./std_;
X_te(:,cols) = (X_te(:,cols)- m)./std_;
% save the results
result_tr=X_tr;
result_te=X_te;
end

function [result_tr,result_te,result_y_tr,result_y_te] = standardize_with_y(X_tr,X_te,y_tr,y_te)
%STANDARDIZE Summary of this function goes here
%   Detailed explanation goes here

%  ommit the intercept
cols = 2:size(X_tr,2);
m    = mean(X_tr(:,cols));
std_ =  std(X_tr(:,cols));
X_tr(:,cols) = (X_tr(:,cols)- m)./std_;
X_te(:,cols) = (X_te(:,cols)- m)./std_;
result_tr=X_tr;
result_te=X_te;
% normalise output too
my   = mean(y_tr);
stdy = std(y_tr);
result_y_tr = (y_tr - my)./stdy;
result_y_te = (y_te - my)./stdy;
end

