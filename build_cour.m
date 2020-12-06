function [X_out, X_index] = build_cour(method,X,y)

% Define size parameters
n = size(X,1);
K = size(X,2);

% Set significance level 
alpha = 0.05;



if method=="simple_to_general"
X_s2g = ones(n,1);
R2_s2g = SelectionCriteria(X_s2g,y);

X_index_s2g = 1;
X_remaining = 2:1:K;
H = 1;

while H == 1
    for i = 1:length(X_remaining)
        X_s2g_plus = [X_s2g X(:,X_remaining(i))];
        R2_s2g_plus(X_remaining(i)) = SelectionCriteria(X_s2g_plus,y);
    end
    [R2_s2g_max, X_add_index] = max(R2_s2g_plus);
          
    X_s2g_plus = [X_s2g X(:,X_add_index)];
    X_index_plus = [X_index_s2g X_add_index];

    R = zeros(1,size(X_s2g_plus,2));
    R(1,end) = 1;
    [~, ~, H] = FTest(X_s2g_plus,y,R,0,alpha);
    
    if H == 1
        X_s2g = X_s2g_plus;
        X_index_s2g = X_index_plus;
        X_remaining(X_remaining == X_add_index) = [];
        R2_s2g = R2_s2g_max;
    end
   
    R2_s2g_plus = [];
    
end
X_index = sort(X_index_s2g);
X_out=X_s2g;


elseif method=="general_to_simple"
X_g2s = X;
X_index_g2s = 1:1:K;
X_deleted = [];
H = 0;

while H == 0
    R2_g2s = zeros(1,K);
    for i = 1:length(X_index_g2s)
        X_g2s_min = X_g2s;
        X_g2s_min(:,i) = [];
        R2_g2s(X_index_g2s(i)) = SelectionCriteria(X_g2s_min,y);
    end
    [~, X_delete_index] = max(R2_g2s);
    
    X_index_min = X_index_g2s;
    X_index_min(X_index_min == X_delete_index) = [];

    R = zeros(1,K);
    R(1,X_delete_index) = 1;
    R(X_deleted) = [];
    [~, ~, H] = FTest(X_g2s,y,R,0,alpha);

    if H == 0
        X_deleted = [X_deleted X_delete_index];
        X_g2s = X_g2s_min;
        X_index_g2s = X_index_min;
    end

end
X_index = sort(X_index_g2s);
X_out=X_g2s;
end
end

function [R2] = SelectionCriteria(X,y)
    [~,stat] = ols(X,y);
    R2 = stat.R2;
end 