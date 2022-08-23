function Zin = tlmm_ABCDmatrixtoZinSC(ABCD)
%TLMM_ZMATRIXTOZIN tlmm_ZmatrixtoZin(Zmatrix,Zload)
%   Calculates input impedance for short condition on end of ABCD.
Zin = ABCD(1,2)./ABCD(2,2);
%Zin = Z(1,1);
end

