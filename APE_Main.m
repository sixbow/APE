clear all
close all 
%Data path
addpath('.\Sonnet_data')
filename_begin = 'PPCV0_0_2W';
filename_end = '.csv';

%Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
for i=1:9
    PPCt(i) = PPC_theory(10E-6*i,51E-6,250E-9,10);
end
% PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir)
for i=1:9
    total_filename = filename_begin+string(i*10)+filename_end;
    disp(total_filename);
    PPCs(i) = PPC_sonnet_oneport(50E-6,51E-6,250E-9,total_filename);
end
CPWt = CPW_theory_first_order(0.001,1.099E-9);




%Disp graph for the input impedance
freq = PPCs.get_freq();
f = figure;
hold on
ax = gca;
for i=3:7
    plot(freq,-imag(PPCt(i).Zin(freq)),'color','blue');
    plot(freq,-imag(PPCs(i).get_Zin()),'color','red');
end

plot(freq,CPWt.Zin(freq),'color','cyan');
legend('PPC Theory','Sonnet','CPW Theory')
ax = gca;
hold off


