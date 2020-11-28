function RMSE = FunctionRMSE(X,y)

%to find the best predective model

n = length(X);
for j = 1:n
   X_minus_one_observation = X;
   X_missing = X_minus_one_observation(j,:) ;
   X_minus_one_observation(j,:) = [];

   y_minus_one_observation = y;
   y_missing = y_minus_one_observation(j);
   y_minus_one_observation(j) = [];

   pred_error(j) = PredictionError(X_minus_one_observation,y_minus_one_observation,y_missing,X_missing);       
end

RMSE = (1/n * sum(pred_error.^2,2))^(1/2);

end
