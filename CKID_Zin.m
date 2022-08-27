function Zin = CKID_Zin(freq,Z_h,eps_eff,l,Cppc,Cc)
beta = calcbeta(freq,eps_eff,2.99E8);
Zin = 1i.*((Z_h.*sin(beta.*l).*((Cppc./Cc)+1)-(cos(beta.*l)./(2.*pi.*Cc.*freq)))/(cos(beta.*l)-2.*pi.*Cppc.*Z_h.*freq.*sin(beta.*l)));
end

