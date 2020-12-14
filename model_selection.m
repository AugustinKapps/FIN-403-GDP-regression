function [X_select, idx_select] = model_selection(method,X,y)
lambda = 1000000;
% Define size parameters
k = size(X,2);
% Set significance level 
alpha = 0.05;
% array of indices
indices  = 1:k;
if method=="simple_to_general"
included = boolean(zeros(k,1));
included(1) = 1; %include intercept
H = 1;

while H == 1
    k_remain = k - sum(included);
    crit     = zeros(k_remain,1);
    for i = 1:k_remain
        % include i in included
        with_i = add_i(included,i);
        % fit model
        crit(i)  = criterion(X(:,with_i));
    end
    [~, argmax] = max(crit); 
    % include argmax to model
    with_argmax = add_i(included,argmax);
    % F test 
    remaining_idx = indices(~included);
    R = (1:sum(with_argmax)) == sum(with_argmax(1:remaining_idx(argmax)));
    [~, ~, H] = FTest(X(:,with_argmax),y,R,0,alpha);
    if H == 1 % => H0 : param = 0 is rejected => add argmax to model
        included = add_i(included,argmax);
    end
end
X_select   = X(:,included);
idx_select = indices(included);


elseif method=="general_to_simple"
remaining= boolean(ones(k,1));
H = 0;
while H == 0
    k_remain = sum(remaining);
    crit     = zeros(k_remain,1);
    for i = 1:k_remain
         % remove i from remaining
         without_i = remove_i(remaining,i);
         % run model
         crit(i)  = criterion(X(:,without_i));
    end
    [~, argmax] = max(crit); 
    % F test
    R = (1:k_remain) == argmax;
    [~, ~, H] = FTest(X(:,remaining),y,R,0,alpha);
    if H == 0 % => H0 : param = 0 is not rejected => remove argmax from model
        remaining = remove_i(remaining,argmax);
    end
end
X_select   = X(:,remaining);
idx_select = indices(remaining);

elseif method=="p_val"
remaining = boolean(ones(k,1));
p_val = inf;
while p_val > alpha
    stat = ols(X(:,remaining),y);
    crit = stat.p_values; 
    [p_val, argmax] = max(crit); 
    if p_val > alpha % => H1 : param = 0 is not rejected => remove argmax from model
        remaining = remove_i(remaining,argmax);
    end
end 
X_select   = X(:,remaining);
idx_select = indices(remaining);
end
% ====================================================
%=====================================================
%=====================================================


%=====================================================
%================ HELPER FUNCTIONS ===================
%=====================================================
% add ith 1 of logical array
function [with_i] = add_i(included,i)
    with_i = included;
    remaining_indices = indices(~included);
    with_i(remaining_indices(i)) = 1;
end
% remove ith 1 of logical array
function [without_i] = remove_i(remaining,i)
    without_i = remaining;
    remaining_indices = indices(remaining);
    without_i(remaining_indices(i)) = 0;
end
% selection criterion
function [crit_val] = criterion(X)
    stat = ols_regularised(X,y,lambda);
    crit_val = stat.R2;
end
end
