function [statistics] = FGLS(X,y,method)
% Compute FGLS on the given data using the given method .
% Methods(slide 6 of GLM lecture) : -'hetero': heteroscedasticity model
%                                 : -'time-series' : time series model 
%Outputs:
%statistics : statistics of the computed FGLS
beta = 0;
% if no method specified us classic FGLS
if nargin <= 2
    % number of iteration for the estimation process
    n_iteration = 20;
    % initial ols
    stats_ols = ols(X,y);
    % initial residuals
    residuals = stats_ols.residuals;
    % inital omega matrix
    omega=diag(residuals.^2);

    for i = 1:n_iteration
        % fit model
        Q = X'* (omega\eye(size(X,1)));
        beta=(Q*X)\(Q*y);
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
    
elseif method == 'hetero' 
    % use the following model for residuals: log(e^T*e) = 1 +
    % log(X+min(X)+1) alpha 
    disp("A transformation was applied to X, use tX in the output")
    model = ols(X,y);
    tX = X(:,2:end);
    tX = tX - min(tX) + 1;
    one_v = ones(size(X,1),1);
    Z  = [one_v, log(tX)];
    tX = [one_v, tX];
    s  = log(model.residuals.^2);
    % ln(?2i)= Z * alpha
    alpha = ols(Z,s);
    % ??^2=exp(Z * alpha)
    W     = diag(exp(Z*alpha.beta));  
    beta  = inv(tX'*inv(W)*tX)*tX'*inv(W)*y;
    statistics = compute_statistics(tX,y,beta);
    statistics.tX = tX;
    
elseif method == 'time-series' 
    % use the following model for residuals: log(e^T*e) = 1 +
    % log(X+min(X)+1) alpha 
    model = ols(X,y);
    % then sigma2 = r^{|i-j|} <=> log(sigma2) = |i-j| * r 
    n = size(X,1);
    Z = ones(n,n) .* (1:n); 
    Z = abs(Z - Z'); % Z = |i-j|
    s = log(model.residuals.^2);
    alpha = ols(Z,s);
    rho   = abs(mean(alpha.beta));
    W     = rho .^ Z;  
    beta  = inv(X'*inv(W)*X)*X'*inv(W)*y;
    statistics = compute_statistics(X,y,beta);
else
    disp("Error bad argument")
end

end

