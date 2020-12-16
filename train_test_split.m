function [tr,y_tr,te,y_te] = train_test_split(data)
%Split the given dataset into a train set (80%) and a test (20%). Also
%extract the target variable (GDP) form the dataset
%Outputs:
%   tr : train set
%   te : test set
%   y_tr : train target
%   y_te : test target

% determine the index where to split
split_index = int32(size(data,1)*0.8) + 1;

% extract the target and split the data
tr   = data(1:split_index,1:end-1);
te   = data(split_index:end,1:end-1);
y_tr = data(1:split_index,end);
y_te = data(split_index:end,end);
end

