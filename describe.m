function [matrix] = describe(table)
data = table2array(table);
minimum  = round(min(data),2);
maximum  = round(max(data),2);
mean_    = round(mean(data,'omitnan'),2);
median_  = round(median(data,'omitnan'),2);
variance_= round(var(data,'omitnan'),2);
skewness_= round(skewness(data),2);
kurtosis_= round(kurtosis(data),2);
matrix = [minimum;maximum;mean_;median_;variance_;skewness_;kurtosis_];
matrix = array2table(matrix);
matrix.Properties.VariableNames = table.Properties.VariableNames;
matrix.statistics = ["min";"max";"mean";"median";"variance";"skewness";"kurtosis"];
end

