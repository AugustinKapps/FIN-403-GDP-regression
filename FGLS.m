function [beta,statistics] = FGLS(X,y)
%FGLS Summary of this function goes here
%   Detailed explanation goes here

[~,stats_ols]=ols(X,y);
residuals=stats_ols.residuals;
omega=diag(residuals.*residuals);

beta=X'*inv(omega)*X\X'*inv(omega)*y;

y_hat=X*beta;

[statistics] = stats(X,y,y_hat);

end

