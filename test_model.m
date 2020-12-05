function [result] = test_model(beta,X_test,y_test)
n=size(X_test,1);
K=size(X_test,2);



y_hat=X_test*beta;

residuals = y_test-y_hat  ;
SSE = residuals'*residuals;
SST = sum((y_test-mean(y_test)).^2);
R2  = 1 - SSE/SST;
adj_R2 = 1 - (n-1)/(n-K) * (1-R2);

result=struct()
result.residuals=residuals;
result.SSE=SSE;
result.SST=SST
result.R2=R2
result.adj_R2=adj_R2;
result.y_hat=y_hat;
end

