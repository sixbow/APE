function F0 = F0_theoryV2(freq,l,A,epsilon_r_dielectic , Z0,epsilon_eff,d)
%F0 = F0_theory(freq[Hz],lenght_CPW[m],AreaPPC[m^2],Z0[Ohm],epsilon_eff[-],d[m],speed of light[m/s]) gives the theoretical formula for
%the resonance frequency of a Compact KID.

epsilon0 = 8.854187E-12;% [C/m]
c = 299792458;

Cppc = PPCAreatocap( A, d , epsilon_r_dielectic,'native') 

theta = 2*pi*((sqrt(epsilon_eff)*freq)/c)*l
F0 = ((1)/(2*pi*Cppc*Z0*tan(theta)));

end

