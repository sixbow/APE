function error = newCouplingAnalytic(eps_eff, Z0 ,AreaPPC,  phyconst , eps_r , AreaCoupler , F0_guess,l , d)
%function of which output must go to zero to find the coupled resonace
%frequency of a CKID.

%calcbeta(F0_guess,epsilon_eff,phyconst.c)

Cppc = PPCAreatocap(AreaPPC,d,eps_r,'base')
Cc = PPCAreatocap(AreaCoupler,d,eps_r,'base')

theta = calcbeta(F0_guess,eps_eff,phyconst.c)*l;
error = Z0*sin(theta)/(cos(theta)-2*pi*F0_guess*Cppc*Z0*sin(theta)) - (1)/(2*pi*Cc);

end

