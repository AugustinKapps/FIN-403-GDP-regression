function V = VuongStatistic(X,y,regressors_model_1,regressors_model_2)

n = length(y);

X_1 = X(:,regressors_model_1);
X_2 = X(:,regressors_model_2);

param_1 = X_1'*X_1\X_1'*y;
param_2 = X_2'*X_2\X_2'*y;

e_1 = y - X_1 * param_1;
e_2 = y - X_2 * param_2;

e_sq_1 = e_1'*e_1;
e_sq_2 = e_2'*e_2;

log_diff = -0.5 * (log(e_sq_1/n) + e_1 .* e_1 /(e_sq_1/n)) + 0.5*(log(e_sq_2/n) + e_2 .* e_2 /(e_sq_2/n));
KLIC1_KLIC0 = mean(log_diff);
var_log_diff = var(log_diff,1);
V = sqrt(n) * KLIC1_KLIC0 / sqrt(var_log_diff);



end
