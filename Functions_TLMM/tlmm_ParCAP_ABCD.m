function matrix = tlmm_ParCAP_ABCD(freq,structure)
%tlmm_ParCAP_ABCD(freq,structure) calculates the ABCD matrix for a parralel
%capacitor
%It expects the structure to be a struct with the fields:
% structure.C [F]
A = 1;
B = 0;

C = 1j*2*pi*structure.C;
D = 1;

matrix = [ A B ; C D ];
end

