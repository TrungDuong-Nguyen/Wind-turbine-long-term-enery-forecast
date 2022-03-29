% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Monthly Correlation with Ref'; 
Mast_Measurements = xlsread(filename,sheetname); 
 
%... 
 
% WS@70m --> col = 8 
WS_70m = Mast_Measurements(:,8); 
% WS@80m --> col = 7 
WS_80m = Mast_Measurements(:,7); 
 
% Index of common valid data in both WS@70m and WS@80m 
Index_com_vd = find(WS_70m~=9999 & WS_80m~=9999); 
 
% Linear correlation model with degree n = 1: y = p1*x + p2 
[f_WS70m_WS80m,gof_WS70m_WS80m] = fit(WS_70m(Index_com_vd,1),WS_80m(Index_com_vd,1),'poly1');  
 
% Linearly Interpolated SS WS@80m from WS@70m   
SS_WS80m = 9999*ones(length(WS_70m),1); 
Index_vd_WS70m = find(WS_70m~=9999);      % Index of valid data in WS@70m 
Temp = feval(f_WS70m_WS80m,WS_70m(Index_vd_WS70m)); 
 
% Round result to 4 decimal places 
SS_WS80m(Index_vd_WS70m,1)= round(Temp*10000)/10000;  