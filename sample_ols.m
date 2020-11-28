function [par_hat]=sample_ols(X,Y,R,m)

% Draw R samples of size m from the creation matrix X and the target vector Y
% and caculate the OLS parameter for each sample.
% Can be used to find bias 

Ys = zeros(m,R);
X1s = zeros(m,R);
par_hat = zeros(2,R);

for i = 1:R
    [Ys(:,i), idx] = datasample(Y,m);  % Draw sample of Y with replacement
    X1s(:,i) = X(idx);                % Find corresponding X
    Xs = [ones(m,1), X1s(:,i)];        % Add intercept to design matrix X
    par_hat(:,i) = Xs'*Xs\Xs'*Ys(:,i); % Determine OLS estimates
end
