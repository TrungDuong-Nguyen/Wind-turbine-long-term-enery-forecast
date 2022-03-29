%% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Mast measurements'; 
Mast_Measurements = xlsread(filename,sheetname); 
 
 
% Index of valid data in WD@10m (WD@10[m/s] -> col = 13) 
Index_vd_WD10m = find(Mast_Measurements(:,13)~=9999); 
  
% Index of valid data in WD@78m (WD@78[m/s] -> col = 12) 
Index_vd_WD78m = find(Mast_Measurements(:,12)~=9999); 
  
% Index of valid data in both WD@10m and WD@78m 
Index_vd_common = intersect(Index_vd_WD10m,Index_vd_WD78m); 
WD10m_vd_common = Mast_Measurements(Index_vd_common,13); 
WD78m_vd_common = Mast_Measurements(Index_vd_common,12); 
 
 
%% Relationship between WD@10m and WD@78m (referring to mean offset approach) 
 
direction_edges = 0:10:360; % Define 36 sectors of 10 degree width 
 
% Return sector index for each valid data point in WD10m 
[Nb_Datapoints,Index_Sector] = histc(WD10m_vd_common,direction_edges); 
 
% In each sector, compute the mean value of the veers between WD78m & WD10m 
Mean_veer = zeros(36,1); 
for i = 1:1:36 
    Mean_veer(i,1)= mean(WD78m_vd_common(Index_Sector == i) - WD10m_vd_common(Index_Sector == i)); 
end 
  
% Calculate the offset values: these values are retrieved from the Mean_veer  
% vector above depending on the values of WD@10m (Reference data) 
WD10m = Mast_Measurements(:,13); 
offset_values = 9999*ones(length(Index_vd_WD10m),1); 
for j = Index_vd_WD10m 
    [n,bin] = histc(WD10m(j),direction_edges); 
    offset_values(j,1) = Mean_veer(bin,1);     
end 
  
% Add the offset values to Reference data (valid data points of WD@10m) to obtain SS_WD@78m 
SS_WD78m = 9999*ones(length(WD10m),1); 
SS_WD78m(Index_vd_WD10m,1) = WD10m(Index_vd_WD10m) + offset_values(Index_vd_WD10m); 

% Round result to 4 decimal places  
SS_WD78m = round(SS_WD78m*1000)/1000; 