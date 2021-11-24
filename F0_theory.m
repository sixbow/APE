function F0 = F0_theory(freq,l,A)
%F0 = F0_theory(freq,lenght_CPW,AreaPPC) gives the theoretical formula for
%the resonance frequency of a Compact KID.

d = 250E-9;
epsilon0 = 8.854187E-12;% [C/m]
%l = 0.001;
c = 2.98E8;
epsilon_eff = 10.6009;
theta = 2*pi*((sqrt(epsilon_eff)*freq)/c)*l;
Z0 = 76.28;
F0 = ((d)/(2*pi*epsilon0*epsilon_eff*Z0*tan(theta)))*((1)/(A));

end

