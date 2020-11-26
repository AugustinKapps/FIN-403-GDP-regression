function [data] = preprocess(file)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here
data = readtable(file);
start_year = 3;
remove_col = 'COL17';
data = removevars(data,{remove_col});
data = data(start_year:end,1:end);
data = [ones(size(data,1),1) table2array(data)]
end

