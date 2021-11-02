clear all
close all 
%Data path
addpath('.\Sonnet_data')
filename_begin = 'PPCV0_0_2W';
filename_end = '.csv';
filename_CPW_SC = 'AlHybridV0_0_1_SC.csv';
%Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
for i=1:9
    PPCt(i) = PPC_theory(10E-6*i,51E-6,250E-9,10);
end
% PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir)
for i=1:9
    total_filename = filename_begin+string(i*10)+filename_end;
    PPCs(i) = PPC_sonnet_oneport(i*10E-6,51E-6,250E-9,total_filename,8);
end
CPWt = CPW_theory_first_order(0.001,1.099E-9);
CPWs = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_SC,9);




%Disp graph for the input impedance
freq = PPCs.get_freq();
f = figure;
hold on
ax = gca;
for i=5:7
    plot(freq,-imag(PPCt(i).Zin(freq)));
    %[x_intersect_t(i),y_intersect_t(i)] = find_intersect_2lines(PPCt(i).get_freq(),CPWt.get_freq(),imag(PPCs(i).Zin()),-imag(CPWs.Zin()),'linearinterp',1);
    plot(freq,-imag(PPCs(i).get_Zin()));
    [x_intersect_s(i),y_intersect_s(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWs.get_freq(),-imag(PPCs(i).Zin()),imag(CPWs.Zin()),'linearinterp',0);
    
    disp(PPCs(i).get_W());
end

plot(x_intersect_s(5:7),y_intersect_s(5:7),'o')
% Finding crossing points
%[x_intersect,y_intersect] = find_intersect_2lines(PPCs(5).get_freq(),CPWs.get_freq(),imag(PPCs(5).Zin()),-imag(CPWs.Zin()),'linearinterp',1);






plot(freq,imag(CPWt.Zin(freq)));
plot(CPWs.get_freq(),imag(CPWs.get_Zin))
legend('PPC Theory','Sonnet','CPW Theory')
ax = gca;
xlabel('[Hz]')
ylabel('Im(Z_{in}) [\Omega]')
title('PPC and CPW input impedance')
hold off


