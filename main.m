<<<<<<< HEAD
china = readtable('data/china.csv');  % skips the first three rows of data
korea = readtable('data/korea.csv');
taiwan = readtable('data/taiwan.csv');


function [train,test] = split_train_test(data,split_index)
    
end 
=======
china  = preprocess('data/china.csv');
korea  = preprocess('data/korea.csv');
taiwan = preprocess('data/taiwan.csv');

k = size(china,2)

[china_tr,y_china_tr,china_te,y_china_te] = train_test_split(china);
[korea_tr,y_korea_tr,korea_te,y_korea_te] = train_test_split(china);
[taiwan_tr,y_taiwan_tr,taiwan_te,y_taiwan_te] = train_test_split(china);
plot(taiwan_te(1:end,2),y_taiwan_te);


[cond,VIF] = colinearity_analysis(china_tr)

% assumption  A1-A6
[beta,statistics] = ols(taiwan_tr,y_taiwan_tr)
[test_statistics] = stats(taiwan_te,  y_taiwan_te, taiwan_te * beta)
%model = fitlm(taiwan_tr,y_taiwan_tr)
>>>>>>> 0906998155bd8b91dbff14243805ce7c8679e618
