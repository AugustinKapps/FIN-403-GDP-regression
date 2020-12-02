function [p_val] = wald_test(X,y,param,R,q)
% Wald test : model restriction
n = size(X,1);
k = size(X,2);
J = size(R,1);
[~,~,sigma2,~,~] = stats(X,y,X*param);
% test
m = (R*param-q);
variance = (1/sigma2)*inv(R*inv(X'*X)*R')/J;
wald = m'*variance*m;
p_val = 1-fcdf(wald,J,n-k);
end

