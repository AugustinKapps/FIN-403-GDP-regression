function [res] = min_max_scaler(data)
%Rescale the given data by applying a min max scaler.
%Output:
%res : result of the rescaling

% compute min and max
m=min(data)
M=max(data)
% rescale the data
res=(data-m)./(M-m)
end

