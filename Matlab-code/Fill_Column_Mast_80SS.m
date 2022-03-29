% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Mast measurements'; 
  
% Read complete Excel worksheet 
[num,txt,raw] = xlsread(filename,sheetname); 
 
Date = raw(24:end,2); 
[MonthNum, MonthString] = month(Date,'mm/dd/yyyy'); 
Year = year(Date,'mm/dd/yyyy'); 
 
% Initialize vectors of monthly mean values and coverage for 2 years 2011 & 2012 
Monthly_mean11 = zeros(11,1); Coverage11 = zeros(11,1); 
Monthly_mean12 = zeros(12,1); Coverage12 = zeros(12,1); 

% Perform statistics for 11 months in 2011 (Feb-Dec)& 12 months in 2012 (Jan-Dec) 
 
for mon = 1:11 
    % Index of valid data in each month 
    Index = Year==2011 & MonthNum(:,1)==mon+1 & SS_WS80m~=9999; 
     
    Monthly_vd = SS_WS80m(Index,1);         % Valid data in each month      
    Temp = mean(Monthly_vd);                           % Monthly mean value 
    Monthly_mean11(mon,1) = round(Temp*10000)/10000; 
     
    % Coverage 
    Temp= length(Monthly_vd)/length(find(Year==2011 & MonthNum(:,1)==mon+1))*100; 
    Coverage11(mon,1) = round(Temp*100)/100;    
end 
%} 
  
% Repeat in the same way with year 2012 
for mon = 1:12     
    Index = Year==2012 & MonthNum(:,1)==mon & SS_WS80m~=9999; 
     
    Monthly_vd = SS_WS80m(Index,1);     
    Temp = mean(Monthly_vd); 
    Monthly_mean12(mon,1) = round(Temp*10000)/10000; 
     
    Temp = length(Monthly_vd)/length(find(Year==2012 & MonthNum(:,1)==mon))*100; 
    Coverage12(mon,1) = round(Temp*100)/100;    
end 