function [corr_] =correlations(variables, target)
%Plot scatters of the variables wtr to the given target and return the
%correlation coefficients. Return the correlations between target and
%variables

% Top two plots
tiledlayout(4,5) % at most 5*4=20 variables to represent

for i = 1:size(variables,2)
   nexttile
   scatter(variables(1:end,i),target)
   title("variable :" + int2str(i))
   
end  
corr_=corr(target',variables);
end

