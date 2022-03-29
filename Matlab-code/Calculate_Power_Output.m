% Load data 
filename = 'Wind-turbine-long-term-energy-forecast_Workbook.xlsx'; 
sheetname = 'Total Power Output'; 
  
% Get the Speed-ups vector (36 values) 
PowerCurve_values = xlsread(filename,sheetname); 
 
% Because 2,5 m/s is the cut-in speed; 25.5 m/s is the cut-out speed 
% Range of meaningful frequency distribution: Prob_Matrix(4:26,:) 
Gross_Energy = zeros(length(PowerCurve_values)-2,1); 
  
for i = 3:length(PowerCurve_values) 
    Gross_Energy(i,1)= 8766*(sum(Prob_Matrix(i+1,:))/100)*PowerCurve_values(i,2); 
end 
 
% Total gross energy per annum  
Total_GE = sum(Gross_Energy);