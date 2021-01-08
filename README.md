# FIN-403 project: GDP regression
 
In this `README`, we will briefly present how our code is structured and how it can be run.
 
## Organisation of the submission
 
Our project has the following file structure:

    .
    ├── data                                      # Data folder
    │ ├── china.csv                               # example file 
    │ ├── ...                                     # ...
    ├── figures                                   # Figure folder (part of the report)
    │ ├── china_residuals.jpg                     # example file 
    │ ├── ...                                     # ...
    ├── summary_stats                             # contains summary stats
    │ ├── summary_stats_china.csv                 # example file 
    │ ├── ...                                     # ...
    ├── <name>.m                                  # matlab functions used
    ├── ...                                       # ...
    ├── notebook_1_explanatory_analysis.mlx       # 1st matlab live script (usage of <>.m ft)
    ├── ...                                       # ...
    ├── notebook_<x>_<description>.mlx            # xth matlab live script
    ├── README.md                            



## How to run our code and reproduce the results
 
All the findings reported in the `latex` file come from the live script files:
 
1. `notebook_1_explanatory_analysis.mlx` : summary statistics, distribution visualisation and correlation matrix
2. `notebook_2_model_selection.mlx`   : VIF analysis, colinearity reduction, and model selection (simple to general, general to simple, polynomial expansion, etc.)
3. `notebook_3_assumption_analysis.mlx` : study which of the A1-6 assumptions are valid 
4. `notebook_4_structural_break.mlx`   : test for structural break for some countries
5. `notebook_5_ridge_reg.mlx`      : extension: Ridge regression to reduce overfitting
6. `notebook_6 final_models.mlx`     : final models (interpretation section in the report)
 
The notebook number indicates the chronological order in which they have been created. This order follows the outile of our report.
However, note that they can be run independently.
 
> *Remark*: the code is completely independent of the chosen country. At the beginning of each notebook, the data is loaded and the country for which the analysis is required needs to be selected. You can select one of the following strings: ```'china', 'korea', 'taiwan``` 
and run the notebook to get the results.
 
Regarding the ```.m``` files, we created several types:
 
* Statistical tests:
  * FTest.m
  * t_test.m
  * wald_test.m
  * Breusch_Pagan_test.m
  * structural_break_test.m
  * VuongStatistic.m
* Statistical functions:
  * robust_CI.m
  * describe.m: summary statistics
  * compute_statistics.m: stats of the OLS estimator (SE, AIC, R2, etc.)
  * colinearity_analysis.m: VIF and condition number
* Modeling:
  * ols.m: least squares estimators
  * FGLS.m: feasible general least squares
  * model_selection.m: simple to general, etc.
* Data reading and preprocessing:
  * preprocess.m: delete nans and CGDP column
  * select_and_normalize.m: select subset of columns found by `notebook_2_model_selection.mlx` and normalise data.
  * standardize.m: standard scaler
  * min_max_scaler.m: use min max scaling procedure
  * log_transform.m: perform a log transformation.
  * expand.m: polynomial feature expansion (all interaction and degree 2 terms)
* Train/Test functions: 
  * train_test_split.m: split data into train/test set.
  * test_model.m: predict stats on test set.
 
In most of the cases, we tried to modularise code. Furthermore, the return object (of ```.m``` files) is usually a struct with named fields to make the code easier to read and follow.
Note that all functions are well documented. For the `tests`, we usually tried to follow the same structure as done in the programming exercises of the course:
> Return `test_stats`, `critical_value` and `H` (result of `test_stats > critical_value`)
 
Finally, we followed a similar approach as done in the Matlab library functions in terms of `ols` output:
 
> Return a struct with all quantities of interest already computed: `AIC`, `R2`, `SE`, `CI`, etc.
 
## Important information
 
Note that we used the Matlab version: `R-2019-a update 9`.
The VIF analysis has a huge impact on our study and it is highly influenced by the method used to compute eigenvalues of a matrix (small eigenvalues slightly change due to floating-point errors). This method can change according to the version of matlab. 
We hard-coded some of the results that depend on the VIF analysis in order to make the rest of the study coherent even when using a different version of Matlab.
 
## Useful Links 
 
If you need to have access to some version of the code or the report, here are some links. Note that the repository is private ant that you will have to first send us an email so that we can add you to the repostiory.
 
|Name    |Links                             |
|:-----------|:-------------------------------------------------------------|
|dataset   | http://datacentre.chass.utoronto.ca/pwt61/         |
|git repo  | https://github.com/giordano-lucas/FIN-403-GDP-regression  |
|report link | https://www.overleaf.com/4691933793grbqjkcvwwhm       |
 
 
 
