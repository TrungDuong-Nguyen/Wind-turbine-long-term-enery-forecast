direction_edges = 15:30:345; 
speed_edges = [0 0.5:1:49.5]; 
 
% Classify SS_WD78m into 12 direction sectors  
[NbCount_Direction,Index_St_Direction] = histc(SS_WD78m(Index_vd_Turbine),direction_edges); 
NbCount_Direction(end) = []; 
  
% Assign corresponding directional bin to each data point in Turbine WS@100m 
Index = NaN(length(Turbine_WS100m),1); 
Index(Index_vd_Turbine,1) = Index_St_Direction; 
  
% Pre-allocate the matrix of probabilities, note that there isn't any element in 
the first bin (0 <= deg < 15 or 345 <= deg < 360) 
Prob_Matrix = zeros(length(speed_edges)-1,length(NbCount_Direction)-1); 
 
% Compute successively the columns of the matrix of probabilities 
for j = 1:length(NbCount_Direction) 
[NbCount_Speed,Index_St_Speed] = histc(Turbine_WS100m(find(Index == j),1),speed_edges); 
    NbCount_Speed(end) = [];    
    Prob = (NbCount_Speed/length(Index_vd_Turbine))*100; 
    Prob_Matrix(:,j) = Prob; 
end 