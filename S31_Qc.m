function Qc = S31_Qc(S13_mag)
%Qc = S31_Qc(S31(ABS MAG double)) 
% Gives the calculated Qc from the S13
Qc = pi/(2*abs(S13_mag)^2);

end

