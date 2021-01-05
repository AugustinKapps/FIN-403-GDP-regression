function [out] =  structural_break_test(X,y,break_y,year)
% Performs two structural breaks at year "break_y":
% (a) A T-test based on dummy variable
% (b) A F-test using all k variables

% confidence level
alpha = 0.05;
% create output struct
out = struct();
% create dummy
dummy = (year >= break_y);
% include dummy for t test;
X_t    = [X,dummy];
model  = ols(X_t,y);
out.t_p_val = model.p_values(end);
% test significance
out.H_t     = out.t_p_val < alpha;
% include dummy for F-test
X1  = X(~dummy,:); 
X2  = X(dummy,:);
n1  = size(X1,1);
n2  = size(X2,1);
k   = size(X,2);
X_F = [X1         , zeros(n1,k);
       zeros(n2,k), X2];
R   = [eye(k),-eye(k)];
q   = zeros(k,1);
% perform F test
[F_stat, F_crit, H_F] = FTest(X_F,y,R,q,alpha);
% store in output
out.F_stat =  F_stat;
out.F_crit =  F_crit;
out.H_F    =  H_F;
out.dummy =dummy;
end