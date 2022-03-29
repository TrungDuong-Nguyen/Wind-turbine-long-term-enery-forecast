% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Mast measurements'; 
  
% Read complete Excel worksheet 
[num,txt,raw] = xlsread(filename,sheetname); 
 
% Get returns the month in numeric (1-12) and string (Jan-Dec) form  
% given a serial date string. 
Date = raw(24:end,2); 
[MonthNum, MonthString] = month(Date,'mm/dd/yyyy'); 
 
% Pre-allocate vector of monthly mean values 
SS_WS80m_Monthly_means = zeros(12,1);  
 
for mon = 1:12 
    % Index of valid data in each month    
    Index = MonthNum(:,1)==mon & SS_WS80m~=9999; 
   
    Monthly_vd = SS_WS80m(Index,1);                    % Valid data in each month 
    SS_WS80m_Monthly_means(mon,1) = mean(Monthly_vd);  % Monthly mean value     
end 
 
% Round result to 4 decimal places  
SS_WS80m_Monthly_means = round(SS_WS80m_Monthly_means*10000)/10000; 
  
% MOMM 
weight = [31 28.25 31 30 31 30 31 31 30 31 30 31]; 
Temp = sum(weight'.*SS_WS80m_Monthly_means)/sum(weight); 
SS_WS80m_MOMM = round(Temp*10000)/10000; 
 
% Max and average  
max_value = max(SS_WS80m(Index_vd_WS70m,1)); 
avg_value = mean(SS_WS80m(Index_vd_WS70m,1)); 
 
Nb_period = length(SS_WS80m);             % Total number of period 
Nb_period_vd = sum(SS_WS80m~=9999);       % Number of period of valid data 