function [minimum, maximum, mean_, median_, variance_, skewness_, kurtosis_] = describe(data)
minimum=min(data);
maximum=max(data);
mean_=mean(data);
median_=median(data);
variance_=var(data);
skewness_=skewness(data);
kurtosis_=kurtosis(data);
end

