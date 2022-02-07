function Zin = tlmm_ZmatrixtoZin(Z,Zload)
%TLMM_ZMATRIXTOZIN tlmm_ZmatrixtoZin(Zmatrix,Zload)
%   Calculates input impedance for a load of Zload
Zin = Z(1,1) - ((Z(1,2)*Z(2,1))/(Z(2,2)+Zload));
%Zin = Z(1,1);
end

