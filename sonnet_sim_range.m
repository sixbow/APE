function Fmaxmin = sonnet_sim_range(F0,dF)
%sonnet_sim_range(F0,dF) is a simple tool to calculate the max and minimum
%of the simulation range to have nice simulation curve
max = (F0*(1-0.0035))+dF;
min = (F0*(1-0.0035)) -dF;
Fmaxmin = [min  max ];
end

