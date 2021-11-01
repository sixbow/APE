clear all
close all 
%Data path
addpath('.\Sonnet_data')

%Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
PPCt = PPC_theory(50E-6,51E-6,250E-9,10);
% PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir) 
PPCs = PPC_sonnet_oneport(50E-6,51E-6,250E-9,'PPCV0_0_2W50.csv');
%Disp graph for the input impedance
freq = PPCs.get_freq();
hold on
plot(freq,imag(PPCt.Zin(freq)));
plot(freq,imag(PPCs.get_Zin()));
legend('Theory','Sonnet')
hold off


