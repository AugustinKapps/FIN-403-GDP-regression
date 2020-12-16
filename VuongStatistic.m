function [V,H] = VuongStatistic(X,y,regressors_model_1,regressors_model_2)

n = length(y);


X_1 = X(:,regressors_model_1);
X_2 = X(:,regressors_model_2);

model_1=ols(X_1,y);
model_2=ols(X_2,y);

log_1=  (log(model_1.SSE/n) + model_1.residuals .*  model_1.residuals /(model_1.SSE/n));
log_2=  (log(model_2.SSE/n) + model_2.residuals .*  model_2.residuals /(model_2.SSE/n));

log_diff = -0.5 * log_1 + 0.5*log_2;
if log_diff==0
V=0;
else 
KLIC1_KLIC0 = mean(log_diff);
var_log_diff = var(log_diff,1);
V = sqrt(n) * KLIC1_KLIC0 / sqrt(var_log_diff);
end

%%%%%%%%%%%%%%%%%%%%%%%% compute the hypothesis %%%%%%%%%%%%%%%%%%%%%%%%%
% H=0 => models are equal
% H=1 => regressors_model_1 is better
% H=-1 => regressors_model_2 is better

alpha=0.05; % confidence level
l_q=norminv(alpha/2); % low normal quantile
h_q=norminv(1-alpha/2); % high normal quantile
H=0;
if V > h_q
   H=1;
end 

if V < l_q
   H=-1;
end 

end
