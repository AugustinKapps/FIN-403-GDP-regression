function [res] = expand(X,degree,add_interractions,add_logs)
%EXPAND Summary of this function goes here
%   Detailed explanation goes here

res=X;
% we don't want to expand the intercept
X=X(:,2:size(X,2));
tmp=X;
for deg=1:degree-1
    tmp=tmp.*X;
    res=[res,tmp];
end


if add_interractions
   interractions=[];
   for c_1=1:size(X,2)
       for c_2=1:size(X,2)
           % condition to avoid duplicate
           if c_1>c_2
               interaction=X(:,c_1).*X(:,c_2);
               interractions=[interractions,interaction];
           end
       end 
   end
   res=[res,interractions];
end

if add_logs
    res=[res,log(X)];
end


end

