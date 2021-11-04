clear all
close all 
%Data path
addpath('.\Sonnet_data')
filename_begin = 'PPCV0_0_3W';
filename_end = '.csv';
filename_CPW_SC = 'AlHybridV0_0_3_SC.csv';
filename_CPW_PEC = 'AlHybridV0_0_3_PEC.csv';

iterator = 1:9;
size_step_W = 5E-6;
size_namestep_W = 5;
begin_name_W = 10;
%Constructs the PPC theory  and PPC sonnet objects.
PPCt = repmat(PPC_theory(),1,length(iterator));% convoluded way of preallocating an array of the objects
PPCs = repmat(PPC_sonnet_oneport(),1,length(iterator));% convoluded way of preallocating an array of the objects
for i=iterator
    %Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
    PPCt(i) = PPC_theory(size_step_W*i,50E-6,250E-9,10);
    total_filename = filename_begin+string((i-1)*size_namestep_W+begin_name_W)+filename_end;
    % PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir)
    PPCs(i) = PPC_sonnet_oneport(size_step_W*i,50E-6,250E-9,total_filename,8);
end
% Constructs the CPW objects.
CPWt = CPW_theory_first_order(0.001,1.099E-9);
CPWsSC = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_SC,9);
CPWsPEC = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_PEC,9);

%Disp graph for the input impedance
freq = PPCs.get_freq();
f = figure;
hold on
ax = gca;
plot_iterator = 3:7;
for i=plot_iterator
    plot(freq,-imag(PPCt(i).Zin(freq)));
    %[x_intersect_t(i),y_intersect_t(i)] = find_intersect_2lines(PPCt(i).get_freq(),CPWt.get_freq(),imag(PPCs(i).Zin()),-imag(CPWs.Zin()),'linearinterp',1);
    plot(freq,-imag(PPCs(i).get_Zin()));
    [x_intersect_s(i),y_intersect_s(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsSC.get_freq(),-imag(PPCs(i).Zin()),imag(CPWsSC.Zin()),'linearinterp',0);
    
    disp(PPCs(i).get_W());
end

plot(x_intersect_s(3:7),y_intersect_s(3:7),'o')
% Finding crossing points
%[x_intersect,y_intersect] = find_intersect_2lines(PPCs(5).get_freq(),CPWsSC.get_freq(),imag(PPCs(5).Zin()),-imag(CPWsSC.Zin()),'linearinterp',1);

plot(freq,imag(CPWt.Zin(freq)));
plot(CPWsSC.get_freq(),imag(CPWsSC.get_Zin))
plot(CPWsPEC.get_freq(),imag(CPWsPEC.get_Zin))
legend('PPC Theory','Sonnet','CPW Theory')
ax = gca;
xlabel('[Hz]')
ylabel('Im(Z_{in}) [\Omega]')
title('PPC and CPW input impedance')
hold off


