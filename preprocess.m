function [data] = preprocess(file)
%PREPROCESS Summary:
% @param  file: (String) path to data
% @return data: a matrix where CGNP is removed as well as all rows
% containing missing values. 
% /!\ note that an intercept is also added.
data = readtable(file);
remove_col = 'CGNP';
% remove CGNP
data = removevars(data,{remove_col});
data = table2array(data);
% filter nan rows
data(any(isnan(data), 2), :) = [];
data = [ones(size(data,1),1),data];

end

