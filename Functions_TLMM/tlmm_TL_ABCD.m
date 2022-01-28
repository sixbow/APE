function matrix = tlmm_TL_ABCD(freq,structure)
%tlmm_TL_ABCD(freq,structure) calculates the ABCD matrix for a transmission
%line
%It expects the structure to be a struct with the fields:
% structure.eps_eff  [-]
% structure.Z0       [Ohm]
% structure.length   [m]
beta = calcbeta(freq, structure.eps_eff,2.98E8);
A = cos(beta*structure.length);
B = 1j*structure.Z0*sin(beta*structure.length);

C = 1j*(1/structure.Z0)*sin(beta*structure.length);
D = cos(beta*structure.length);

matrix = [ A B ; C D ];





end

