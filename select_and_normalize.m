function [data] = select_and_normalize(country,model_selection)
% Load data corresponindg to the given country and select the needed
% columns(from VIF analysis) and also from the model selection analysis (if required)

% path of the data
path=strcat('data/',country,'.csv'); 
% load and preprocess the data
data = preprocess(path);
[tr,y_tr,te,y_te] = train_test_split(data);
%normalise and select subfeatures

% as we explain in the report, matlab version might influence the result of
% VIF. Thus we hard coded the result we had to make the rest of the
% analysis coherent
switch country
    case 'korea'
        selection = [true;false;false;true;false;false;false;true;false;true;false;true;true;false;true;true;false;true];
    case 'china'
        selection = [true;false;true;false;true;false;true;true;true;true;false;true;false;false;true;false;false;false];
    case 'taiwan'
        selection = [true;false;true;false;false;true;false;true;false;true;false;false;false;false;false;false;false;true];
end

% apply selection and standardize
[tr,te]  = standardize(tr(:,selection),te(:,selection));


% apply the results of model selection if required
if nargin >1 && model_selection
    switch country
        case 'korea'
             te = te(:,[1,2,3,4,5,6,7,8]);
             tr = tr(:,[1,2,3,4,5,6,7,8]);   
        case 'china'
             te = te(:,[1,2,4,5,8]);
             tr = tr(:,[1,2,4,5,8]);
        case 'taiwan'
             te = te(:,[1,2,3,4,5]);
             tr = tr(:,[1,2,3,4,5]);
    end
end

% save the results
data = struct();
data.tr = tr;
data.te = te;
data.y_tr = y_tr;
data.y_te = y_te;
data.country_name = country;





end

