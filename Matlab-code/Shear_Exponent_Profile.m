% 4 data points corresponding to mast at 30 – 50 - 70 – 80m 
speed = [4.8118 5.2957 5.6057 5.7680]; 
height = [30 50 70 80]; 
 
% Linear correlation model with degree n = 1: y = p1*x + p2 
% Calculate (p1, p2) and r-square (R^2) 
f = fit(speed',height','poly1'); 
 
% Calculate wind speed at 100m height 
mast_height = 100; 
Temp = (mast_height - f.p2)/f.p1; 
WS_100m = round(Temp*10000)/10000; 
 
% Calculate the shear exponent alpha (80m -> 100m) 
alpha = log(6.1819/speed(1,4))/log(mast_height/height(1,4)); 