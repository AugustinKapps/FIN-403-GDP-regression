function [data] = preprocess(file,standardize)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here
data = readtable(file);
remove_col = 'CGNP';
data = removevars(data,{remove_col});
data = table2array(data);
data(any(isnan(data), 2), :) = [];
data = [ones(size(data,1),1),data];


end

