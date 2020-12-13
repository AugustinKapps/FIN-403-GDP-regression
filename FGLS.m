function [statistics] = FGLS(X,y)
%FGLS Summary of this function goes here
%   Detailed explanation goes here
n_iteration = 20;
stats_ols = ols(X,y);
residuals = stats_ols.residuals;
omega=diag(residuals.*residuals);

for i = 1:n_iteration
    % fit model
    Q = X'* (omega\eye(size(X,1)));
    beta=Q*X\Q*y;
    %beta=X'*inv(omega)*X\X'*inv(omega)*y;
    y_hat=X*beta;
    % improve variance matrix estimator
    residuals = y - y_hat;
    est_var = residuals.*residuals;
    % clip variance to avoid division by 0
    est_var(est_var<1e-10) = 1e-10;
    omega = diag(est_var);    
end

statistics = compute_statistics(X,y,beta);

end

