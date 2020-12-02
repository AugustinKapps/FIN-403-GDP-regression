function [res] = min_max_scaler(data)
%MIN_MAX_SCALER Summary of this function goes here
%   Detailed explanation goes here
m=min(data)
M=max(data)
res=(data-m)./(M-m)
end

