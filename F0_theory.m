function F0 = F0_theory(freq,l,A,Z0,epsilon_eff,d)
%F0 = F0_theory(freq[Hz],lenght_CPW[m],AreaPPC[m^2],Z0[Ohm],epsilon_eff[-],d[m],speed of light[m/s]) gives the theoretical formula for
%the resonance frequency of a Compact KID.

epsilon0 = 8.854187E-12;% [C/m]
c = 299792458;

theta = 2*pi*((sqrt(epsilon_eff)*freq)/c)*l;
F0 = ((d)/(2*pi*epsilon0*epsilon_eff*Z0*tan(theta)))*((1)/(A));

end

