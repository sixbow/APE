clc
clear all 
close all 
Z_TL = 50;
l = 0.001;
eps_eff = 9.9;
Z_h = 82.4;
Cppc = PPCAreatocap(58.3^2,295,7.8,'native')
Cc = PPCAreatocap(4^2,295,7.8,'native')
freq_iter = linspace(5.88E9,5.89E9,100000);
Z_CKID = zeros(1,length(freq_iter));
CKID_Zin(freq_iter(2),Z_h,eps_eff,l,Cppc,Cc)
freq_iter(1)
for i = 1:length(freq_iter)
%Z_CKID(freq_iter(i)) = CKID_Zin(freq_iter(i),Z_h,eps_eff,l,Cppc,Cc);
Z_CKID(i) = CKID_Zin(freq_iter(i),Z_h,eps_eff,l,Cppc,Cc); 
S21_dB(i) = 10*log10(abs( 2/(2+(Z_TL/Z_CKID(i)))));

end

plot(freq_iter,S21_dB);