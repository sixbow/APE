function Fmaxmin = sonnet_sim_range(F0,percent)
%sonnet_sim_range(F0,dF) is a simple tool to calculate the max and minimum
%of the simulation range to have nice simulation curve
max = (F0)*(1+(percent/100));
min = (F0)*(1-(percent/100));
Fmaxmin = [min  max ];
end

