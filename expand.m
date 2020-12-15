function [res,new_col_names] = expand(X,degree,add_interractions,add_logs,col_names)
% Commpute the expansion of a given set of features. The expansion consits
% of a polynomial expansion of degree 'degree', interractions of degree 1
% (if add_interractions is true), a log transformation of the positive
% features (if add_logs is true).
%
%Outputs:
%res  : resulting expansion
%new_col_names : names of the new set of columns

new_col_names=col_names;
res=X;
% we don't want to expand the intercept
col_names=col_names(:,2:size(X,2));
X=X(:,2:size(X,2));
tmp=X;
for deg=1:degree-1
    % compute the expansion
    tmp=tmp.*X;
    % save the expansion
    res=[res,tmp];
    % add degree expansion names, note that we do not consider the intercept
    new_col_names=[new_col_names,strcat(col_names,'^',int2str(deg+1))];
   
end

% add interractions of degree 1 if required
if add_interractions
   interractions=[];
   for c_1=1:size(X,2)
       for c_2=1:size(X,2)
           % condition to avoid duplicate
           if c_1>c_2
               interaction=X(:,c_1).*X(:,c_2);
               % add interaction
               interractions=[interractions,interaction];
               % add interractions names
               new_col_names=[new_col_names,strcat(col_names(c_1),'*',col_names(c_2))]; 
           end
       end 
   end
   % save the interractions
   res=[res,interractions];
end

% add log transformations if required
if add_logs
    % add log tranformations for positive columns
    res=[res,log(X(:,all(X>0)))];
    % add log transformation names
    new_col_names=[new_col_names,strcat('LOG(',col_names(all(X>0)),')')]; 
end




end

