function [model] = ols(X,y,method,lambda)
%Do a least squate regression on the given data (variable X and target y),
%using the given method. Method can be a rigde regression or a
%transformation of X and y
%Outputs:
%   beta : beta obtained from the regression
%   CI   : confidence intervals for each component of beta (with 0.05 confidence level)
%   P    : p values attesting of the significane og each component of beta
%   tX   : log transformation of X (if required)
%   ty   : log transformation of y (if required)
%Also return all the other statistics computed by the compute_statistics
%function.
k = size(X,2);
if nargin <=2
    beta  = (X'*X)\(X'*y);
    model = compute_statistics(X,y,beta);
else 
    switch method     
        case 'ridge'
            beta  = (X'*X+lambda*eye(k))\(X'*y);
            model = compute_statistics(X,y,beta);
        case 'loglog'
            disp('X and y have changed due to log log transformation !')
            X = log_transform(X);
            y = log_transform(y);
            % recursively compute the ols on the transformation
            [model]=ols(X,y);
            % save the transformation of X
            model.tX=X;
            % save the transformation of y
            model.ty=y;
        case 'loglin'
            disp('y has changed due to log transformation')
            y = log_transform(y);
            % recursively compute the ols on the transformation
            [model]=ols(X,y);
            % save the transformation of y
            model.ty=y;
        case 'linlog'
            disp('X has changed due to log transformation')
            X = log_transform(X);
            % recursively compute the ols on the transformation
            [model]=ols(X,y);
            % save the transformation of X
            model.tX=X;
    end

end 




end

