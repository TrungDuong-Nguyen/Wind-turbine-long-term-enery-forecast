% Calculate LT Mast 80SS[m/s] by linearly extrapolating from VMD[m/s] (best R^2) 
  
% VMD -> col = 10, 
VMD_LT = Monthly_Correlation(19:132,10);  % valid data range of VMD 
Temp = feval(f_VMD,VMD_LT); 
Mast_80SS_LT = round(Temp*10000)/10000;