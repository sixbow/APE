function Capacitance = PPCAreatocap(Area,thickness,epsilon_r)
%PPCAreatocap(Area,thickness,epsiloneff) Calculates the capacitance for given Area thickness and epsiloneff
epsilon0 = 8.854187E-12;% [C/m]
Capacitance = ((epsilon0.*epsilon_r.*Area)./thickness);
end

