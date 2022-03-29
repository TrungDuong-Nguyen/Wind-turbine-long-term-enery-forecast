% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Wind Flow modelling'; 
  
% Get the Speed-ups vector (36 values) 
Speed_ups = xlsread(filename,sheetname); 
  
% 
Index_vd_LTWS100m = find(LT_WS100m~=9999); 
Index_vd_SSWD78m = find(SS_WD78m~=9999); 
 
% Index of valid data in both LTWS@100m and WD@78m 
Index_vd_Turbine = intersect(Index_vd_LTWS100m,Index_vd_SSWD78m); 
add_values = zeros(length(Index_vd_Turbine),1); 
 
directional_speedups_edges = 0:10:360; 
ratio_values = zeros(length(Index_vd_Turbine),1);

for i = Index_vd_Turbine 
  [n,bin] = histc(SS_WD78m(i),directional_speedups_edges); 
  ratio_values(i,1) = Speed_ups(bin,2); 
end 
 
% Compute Turbine_WS100m  
Turbine_WS100m = 9999*ones(length(LT_WS100m),1); 
Turbine_WS100m(Index_vd_Turbine) = LT_WS100m(Index_vd_Turbine).*ratio_values(Index_vd_Turbine);  
 
% Round result to 4 decimal places  
Turbine_WS100m = round(Turbine_WS100m*10000)/10000;