% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Monthly Correlation with Ref'; 
  
Monthly_Correlation = xlsread(filename,sheetname); 
 
% Mast_80SS -> col = 13, 
Mast_80SS = Monthly_Correlation(116:138,13); 
 
% Relationship between Mast_80SS and ERA Data 
% ERA -> col = 4, 
ERA = Monthly_Correlation(116:138,4); 
 
% Assume it's a linear interpolation with degree n = 1: y = p1*x + p2 
% p(1) is the slope, p(2) is the intercept of the linear predictor 
[f_ERA,gof_ERA] = fit(ERA,Mast_80SS,'poly1'); 
 
% Relationship between Mast_80SS and MERRA2 Data 
% MERRA2 -> col = 7, 
MERRA2 = Monthly_Correlation(116:138,7); 
[f_MERRA2,gof_MERRA2] = fit(MERRA2,Mast_80SS,'poly1'); 
 
% Relationship between Mast_80SS and VMD Data 
% VMD -> col = 10, 
MERRA2 = Monthly_Correlation(116:138,10); 
[f_VMD,gof_VMD] = fit(VMD,Mast_80SS,'poly1'); 