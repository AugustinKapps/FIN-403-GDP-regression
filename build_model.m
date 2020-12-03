function [X_out] = build_model(method,X,y)




if method=="simple_to_general"
    %(a) simple-to-general
    X_out = [];                    
    p_val = 0;
    remaining=X;
    while (p_val<0.05)
        [X_out, remaining,p_val] = simple_to_general_iterative(X_out,y, remaining);
    end
    
elseif method=="general_to_simple"
    %(a) general-to-simple
    X_out = X; 
    p_val = 1;
    i=0;
    while (p_val>0.05 && i<size(X,2) ) 
        [X_out,p_val] = general_to_simple_iterative(X_out,y);
        i = i+1;
    end

end 



% ==================== HELPER FUNCTIONS ====================
    function [X_out,remaining,p_val] = simple_to_general_iterative(X,y,cols)
        best_c  = 0;
        r2 = -9999999;
        p_val   = 1;
        for c = 1:size(cols,2)
            [~,stats] = ols_augustin([X,cols(:,c)],y);
            if stats.adj_R2 > r2
                best_c  = c;
                r2 = stats.adj_R2;
                p_val = stats.p_values(end); %test the significance of the added column
            end
        end    
        X_out = X;
        if p_val < 0.05
            X_out = [X_out,cols(:,best_c)];
        end
        remaining = cols(:,1:size(cols,2) ~= best_c);
    end

    function [X_out,p_val] = general_to_simple_iterative(X,y)
         [~,stats] = ols_augustin(X,y);
         [p_val, i] = max(stats.p_values);
         if p_val > 0.05
             X_out = X(:,1:size(X,2)~=i-1);% i-1 since X has no intercept
         else 
             X_out = X;
         end
    end
end

