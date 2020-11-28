function [F_stat, F_crit, H] = FTest(X,y,R,q,alpha)

% To reject an hypothesis.

param = X'*X\X'*y;

n = size(X,1);
K = size(X,2);
J = size(R,1);

res = y - X * param;
e_sq = res'*res;
asym_var = e_sq / (n-K) * inv(X'*X);

F_stat = (R * param - q)' * inv(R * asym_var * R') * (R * param - q) / J;
F_crit = finv(1-alpha,J,n-K);

if F_stat > F_crit
    H = 1;
else
    H = 0;
end

end
