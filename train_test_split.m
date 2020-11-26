function [tr,y_tr,te,y_te] = train_test_split(data)
%TRAIN_TEST_SPLIT (80% training set)
split_index = int32(size(data,1)*0.8) + 1;
tr   = data(1:split_index,1:end-1);
te   = data(split_index:end,1:end-1);
y_tr = data(1:split_index,end);
y_te = data(split_index:end,end);
end

