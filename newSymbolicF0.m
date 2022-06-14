function Areappc = newSymbolicF0(d,phyconst , eps_sic ,Z0,eps_r , F0 ,l)
%New formulation of the relation between Area and F0.

Areappc = d./(phyconst.epsilon0.*eps_sic.*2.*pi.*Z0.*F0.*tan(((2.*pi.*sqrt(eps_r).*F0)./(phyconst.c)).*l));

end

