function matrix = tlmm_Shunt_ABCD_Y(Y)
%tlmm_Shunt_ABCD(freq,Z) calculates the ABCD matrix for a shunt
%impedance

A = 1;
B = 0;

C = Y;
D = 1;

matrix = [ A B ; C D ];
end