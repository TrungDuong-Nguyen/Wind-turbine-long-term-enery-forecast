This repository contains a step-by-step guide to forecast the long-term energy of a wind turbine system.

You can find the raw [Excel workbook](/Wind-turbine-long-term-energy-forecast_Workbook.xlsx) with instructions added. And, following the [guide](/Wind-turbine-long-term-energy-forecast_Compute-guide.pdf), you are able to compute using MATLAB the values requested in the workbook. The outcomes of the computation process are available at the [filled version](/Wind-turbine-long-term-energy-forecast_Filled.xlsx) of the workbook. 

Folder `Matlab-code` contains the `.m` script files. Some important MATLAB functions used in this project are reported hereafter:

1. **Function `xlsread`** (e.g, in script [Reconstruct_SS_WS80m](/Matlab-code/Reconstruct_SS_WS80m.m))

```matlab
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Monthly Correlation with Ref'; 
Mast_Measurements = xlsread(filename,sheetname); 
```
This [function](https://www.mathworks.com/help/matlab/ref/xlsread.html?s_tid=doc_ta) reads a specific worksheet in the Microsoft Excel spreadsheet file, and returns the numeric data in matrix. To read column-oriented data from spreadsheet files (included file with extension `.xls` or `.xlsx`), newer version of MATLAB provides alternative functions like [`readtable`](https://www.mathworks.com/help/matlab/ref/readtable.html), [`readmatrix`](https://www.mathworks.com/help/matlab/ref/readmatrix.html) or [`readcell`](https://www.mathworks.com/help/matlab/ref/readcell.html).

<br>

2. **Function `fit`** (e.g, in script [Reconstruct_SS_WS80m](/Matlab-code/Reconstruct_SS_WS80m.m))

```matlab
[f_WS70m_WS80m,gof_WS70m_WS80m] = fit(WS_70m(Index_com_vd,1),WS_80m(Index_com_vd,1),'poly1');
```

This function is used to obtained the coefficients _p₁_ and _p₂_ of the linear regression model _y = p₁x + p₂_. Notice that the flag _'poly1'_ represents that the model type used to fit here is a linear polynomial curve. [See more details](https://www.mathworks.com/help/curvefit/fit.html?searchHighlight=fit&s_tid=srchtitle_fit_1).

MATLAB also has a built-in function `fit` in the [Predictive Maintenance Toolbox](https://www.mathworks.com/help/predmaint/index.html?s_tid=CRUX_lftnav), which helps to estimate the parameters of a remaining useful life prediction model using historical data.

<br>

3. **Function `feval`** (e.g, in script [Reconstruct_SS_WS80m](/Matlab-code/Reconstruct_SS_WS80m.m))

```matlab
Temp = feval(f_WS70m_WS80m,WS_70m(Index_vd_WS70m)); 
```

This [function](https://www.mathworks.com/help/stats/linearmodel.feval.html?searchHighlight=feval&s_tid=srchtitle_feval_4), based on the linear regression model determined using function `fit` above, returns the corresponding output values obtained by linearly interpolating the input values.

<br>

4. **Function `histc`** (e.g, in script [Estimate SS_WD78m.m](/Matlab-code/Estimate_SS_WD78m.m) and [Frequency_Distribution_WS_WD.m](/Matlab-code/Frequency_Distribution_WS_WD.m))

```matlab
[Nb_Datapoints,Index_Sector] = histc(WD10m_vd_common,direction_edges);
```

This [function](https://www.mathworks.com/help/matlab/ref/histc.html?s_tid=doc_ta) counts the number of values in the first arguments (_WD10m_vd_common_) that are within each specific bin range which endpoints determined by the second arguments (_direction_edges_). The output argument _Nb_Datapoints_ contains the number of element from _WD10m_vd_common_ in each bin, while the output argument _Index_Sector_ is an array of the same size as _WD10m_vd_common_ indicating the bin number that each entry in _WD10m_vd_common_ sorts into. In newer version of MATLAB, user is recommended to switch to function [`histcounts`](https://www.mathworks.com/help/matlab/ref/histcounts.html).