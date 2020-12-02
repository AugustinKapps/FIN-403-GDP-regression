### FIN-403 project: GDP  regression

|Name        |Links                                               |
|:-----------|:---------------------------------------------------|
|data link   |  http://datacentre.chass.utoronto.ca/pwt61/        |
|report link |  https://www.overleaf.com/4691933793grbqjkcvwwhm   |

# Guidelines 

## Explanatory data analysis:

1. describe (mean, median,?) plot distribution
2. correlation analysis
3. PCA

## Models experimentation

### Start by fitting simple OLS
### Understand which assumption can be made

1. Formal collinearity test : reduce number of features using VIF
2. Plot residuals to understand thedistribution and discuss homoscadsticity/exogeneity

### Fit best model according to assumptions (use test-set to make the decision)

1. Use models seen in class
2. Perform model selection (both top-down and bottom-up approaches)

### Feature extension to make further improvements

1. use and  test structural break (historical patterns)
2. simple polyonmial expansion and interaction terms

## Results

1. coefficients give information about increase of input
2. discuss p_values
3. discuss if the set of features selected makes sense.

## Conclusion
what would we do if we had more time:
 
1. name of methods 
2. short justification

## Extension:

apply ML models:

1. regularised regression (since we are interested in prediction model)
2. polynomial extension  +  CV (K-fold)
