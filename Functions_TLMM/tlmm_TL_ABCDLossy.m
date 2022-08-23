function matrix = tlmm_TL_ABCDLossy(freq,structure)
%tlmm_TL_ABCD(freq,structure) calculates the ABCD matrix for a transmission
%line
%It expects the structure to be a struct with the fields:
% structure.eps_eff  [-]
% structure.Z0       [Ohm]
% structure.length   [m]
beta = calcbeta(freq, structure.eps_eff,2.98E8);
alpha = 2*beta*structure.Qi;
gamma = alpha + 1i*beta;
A = cosh(gamma*structure.length);
B = structure.Z0*sinh(gamma*structure.length);

C = (1/structure.Z0)*sinh(gamma*structure.length);
D = cosh(gamma*structure.length);

matrix = [ A B ; C D ];





end

