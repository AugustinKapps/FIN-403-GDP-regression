function [res] = log_transform(x)
        
% check if the given value is y of X (y has no intercept to take into account)
if size(x,2)>1
   % remove intercept
   tX = x(:,2:end);
   % to obtain positive values only
   tX=tX-min(tX)+1;
   one_v = ones(size(x,1),1);
   % place back intercpet and tranform the rest
   res  = [one_v, log(tX)];
else
   % rescale and transform
   res = log(x-min(x)+1);
end 
end
