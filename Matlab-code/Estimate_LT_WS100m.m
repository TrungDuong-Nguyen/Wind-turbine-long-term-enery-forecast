% Compute (SS WS@80m * LT adj) with valid 10 minutes-data 
% Then, extrapolate to 100m using power law with shear exponent alpha 
  
LT_adj = 1.0183; 
alpha = 0.3106; 
  
% Index of valid data of SS_WS80 
Index_vd_SSWS80m = find(SS_WS80m~=9999); 
% Pre-allocate vector LT_WS100m  
LT_WS100m = 9999*ones(length(SS_WS80m),1); 
 
LT_WS100m(Index_vd_SSWS80m,1) = (SS_WS80m(Index_vd_SSWS80m,1)*LT_adj)*(100/80)^alpha; 
 
% Round result to 4 decimal places  
LT_WS100m = round(LT_WS100m*10000)/10000;