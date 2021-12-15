function Capacitance = PPCAreatocap(Area,thickness,epsilon_r,baseunits)
%PPCAreatocap(Area,thickness,epsiloneff,optional['base' or 'native']) Calculates the capacitance for given Area thickness and epsiloneff
% the 'base' option takes in area in [m^2], thickness in [m].
% the 'native' option takes in area in [um^2] and thickness in [nm].
epsilon0 = 8.854187E-12;% [C/m]

if nargin<3
    error('Area,thickness and epsilon r are necessery for function to work.')
end
if nargin<4
    Capacitance = ((epsilon0.*epsilon_r.*Area)./thickness);
end
if strcmp(baseunits,'base')
    Capacitance = ((epsilon0.*epsilon_r.*Area)./thickness);
elseif strcmp(baseunits,'native')
    Area = Area/(1E12);
    thickness = thickness/(1E9);
    Capacitance = ((epsilon0.*epsilon_r.*Area)./thickness);
else
msg = "Non allowed baseunits. baseunits chooser must be 'base'(m^2|m) or 'native'(um^2|nm) !";
error(msg)
end




end

