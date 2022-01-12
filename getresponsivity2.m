function [dthetadN,dRdN,dxdN,abssigma,Qi,Q,Beta] = getresponsivity2(le,alphak,Qc,V,sigma1,sigma2,ds1dn,ds2dn,d,Qim)
% almost the same as V1, but now dx/dN is added
% getresponsivity calcualtes the response per qp for a resonator.
% uses Eqn. 2.26 and 2.27 from the Thesis of Pieter de Visser
%OUTPUTS
% dthetadn = phase response per qp per um^3
% dRdn =  amplitude response per qp per um^3
% dxdn =  dF/Fo  response per qp per um^3 
% Qi is internal Q due to qp
% Q=Q factor, 
%INPUT
%alpha is the kinetic inductance fraction
%sigma1, sigma 2 are the real and imaginary parts of the complex
%conductivity normalised by sigman.
%ds1dn and ds2dn are the changes in sigma per qp, also normalised to
%sigman (the conductvity in he normal state)
%ksi is the bulk coherence length [m]
%mu is the bulk peneration depts [m]
%le is the electon mean free path [m]
%Qc is the resonator coupling Q
%d is aluminium thickness [m]
%Qim=measured Qi
% is the metal layer thickness in m
global ksi0 lambda0;

lambda=lambda0*sqrt(1+ksi0/le);     %effective penetration depth, see p. 18 P de Visser Thesis 
Beta=1+(2*d/lambda)/(sinh(2*d/lambda)); %
Qi=2/(alphak*Beta)*(sigma2./sigma1);%sigman not needed, eqn 2.23pdv
Q=Qi*Qc/(Qi+Qc);

% note that the normal state con ductivity drops out... so it is not used.
% ds1dn, ds2dn are calcualted normalized to sigman
%so we calculate here the abs sigma also normalised to sigma n (easy,
%sigma1,2 are calcualted normalized)
abssigma=1*abs((sigma1-1i*sigma2));%normalized to sigman
if Qim>=Qi % Qim limited by qp (Qim = Qi or Qim>Qi (which is actually onlyu possible due to calcul error)
    dRdN =-alphak*Beta*Q/(V*abssigma) * ds1dn * 1;
else %measured Qim is smaller than qp Qi, qp are not very good visible in Qi
    dRdN=-alphak*Beta*Q/(V*abssigma) * ds1dn * Qim/Qi;
end
prefact=alphak*Beta*Q/(V*abssigma);

dxdN    = -alphak * Beta*0.25/(V*abssigma) * ds2dn;%Pieter 2.27+3.38, frequ. responsivity
dthetadN= -alphak * Beta*Q   /(V*abssigma) * ds2dn;


end

