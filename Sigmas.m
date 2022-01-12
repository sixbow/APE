function [sigma1,sigma2,ds1dnqp,ds2dnqp, nqp] = Sigmas(frequ, N0, Delta0in, T)
% uses analytical expressions to calcualte sigma1/sigman, sigma 2/sigman (2.16, 2.17 Pieter Thesis) 
% all expressions only valid for Delta = Dealta0!
% IN
% frequ     = angular frequency of resonator
% N0        = ensity of sates at fermi level in J-1um-3
% Deltain   = in (meV), used for sigma.
% Delta0in  = in (meV), used for dsigmas.
% T         = temperature value T (K)
% OUT
% sigma 1 and sigma2 are both normalized to sigman (as in 2.16, 2.17)
%  dsigma1dnqp, dsigma2dnqp are both normalized to sigman and per um^3
% (2.18 and 2.19 Pieter thesis)
%  nqp is #quasiparticles/um^3!!!

%NB: 

global hbar kb e_c;%in SI units

Delta0=Delta0in*e_c/1e3;%convert to J

%(2.16, 2.17 Pieter Thesis) 
ksi=hbar.*frequ./(2*kb.*T);
sigma1=4*Delta0./(hbar.*frequ).*exp(-Delta0./(kb.*T)).*sinh(ksi).*besselk(0,ksi);
sigma2=pi*Delta0./(hbar.*frequ).*( 1-2.*exp(-Delta0./(kb.*T)).*exp(-ksi).*besseli(0,ksi)  );

%(2.18 and 2.19 Pieter thesis)    
ds1dnqp=1/N0./(hbar*frequ).*sqrt(2*Delta0/pi/kb./T).*sinh(ksi).*besselk(0,ksi);
ds2dnqp=-1*pi/2/N0./(hbar*frequ).*(1+sqrt(2*Delta0/pi/kb./T).*exp(-ksi).*besseli(0,ksi));
% nqp calcualted for varying Delta: Needs check!
nqp = 2 * N0 * (2*pi*kb*T.*Delta0).^0.5.*exp(-Delta0./(kb.*T));
end

