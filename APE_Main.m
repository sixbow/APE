clc
close all 
clear

%clear all %clear classes % Increasingly strong statements about clearing
%everything

%Data path
addpath('.\Sonnet_data')
filename_begin = 'PPCV0_9_9A';
filename_end = '.csv';
filename_CPW_SC = 'AlHybridV0_0_3_SC.csv';
filename_CPW_PEC = 'AlHybridV0_0_3_PEC.csv';
%% Loading Data and making objects.
A_filename_umsquared = [12710,10056,8320,7094,6184,5480,4920,4464,4086,3766,3493,3257,3051,2869,2708,2564,2434,2317,2211,2114];
A_ppc = A_filename_umsquared.*((1E-6)^2);
iterator = 1:length(A_ppc);
%Constructs the PPC theory  and PPC sonnet objects.
PPCt = repmat(PPC_theory(),1,length(iterator));% convoluded way of preallocating an array of the objects
PPCs = repmat(PPC_sonnet_oneport(),1,length(iterator));% convoluded way of preallocating an array of the objects
for i=iterator
    %Constructor arg: PPC_theory(W (Width PPC(m)),H (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
    PPCt(i) = PPC_theory(sqrt(A_ppc(i)),sqrt(A_ppc(i)),250E-9,10);
    total_filename = filename_begin+string(A_filename_umsquared(i))+filename_end;
    % PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir)
    PPCs(i) = PPC_sonnet_oneport(sqrt(A_ppc(i)),sqrt(A_ppc(i)),250E-9,total_filename,9);
end
% Constructs the CPW objects.
CPWt = CPW_theory_first_order(0.001,1.099E-9);
CPWsSC = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_SC,9);
CPWsPEC = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_PEC,9);

%% Analyse data. Finding the intersects between CPW and PPC curves.
%Disp graph for the input impedance 
freq = PPCs.get_freq();
f1 = figure;
hold on
hcpwsc = sweetplot(CPWsSC.get_freq(),imag(CPWsSC.get_Zin));
hcpwpec = sweetplot(CPWsPEC.get_freq(),imag(CPWsPEC.get_Zin));
hcpwt = plot(freq,imag(CPWt.get_Zin(freq)),'--','linewidth',2);
plot_iterator = iterator;
for i=plot_iterator
    ht(i) = plot(freq,-imag(PPCt(i).get_Zin(freq)),'--');
    hts(i) = plot(freq,-imag(PPCs(i).get_Zin()));
    [x_intersect_sc(i),y_intersect_sc(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsSC.get_freq(),-imag(PPCs(i).get_Zin()),imag(CPWsSC.get_Zin()),'linearinterp',0);
    [x_intersect_pec(i),y_intersect_pec(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsPEC.get_freq(),-imag(PPCs(i).get_Zin()),imag(CPWsPEC.get_Zin()),'linearinterp',0);
    %normalizedtextarrow(gca(),[8.9E9 -imag(PPCs(i).get_Zin(4000))],[(freq(4000)) -imag(PPCs(i).get_Zin(4000))],string(PPCs(i).get_W()*1E6*50))
end
hisc = plot(x_intersect_sc(plot_iterator),y_intersect_sc(plot_iterator),'o');
hipec = plot(x_intersect_pec(plot_iterator),y_intersect_pec(plot_iterator),'o');


xlabel('[Hz]')
ylabel('Im(Z_{in}) [\Omega]')
title('PPC and CPW input impedance')
xlim([1E9 9E9]);
ylim([0 50]);
normalizedtextarrow(gca(),[(freq(4000)-1E9) -imag(PPCt(5).get_Zin(freq(4000)))],[(freq(4000)) -imag(PPCt(5).get_Zin(freq(4000)))],'Theory')% This needs some shaving to get at the right place!
normalizedtextarrow(gca(),[(freq(4250)-1E9) -imag(PPCs(5).get_Zin(4250))],[(freq(4250)) -imag(PPCs(5).get_Zin(4250))],'Sonnet PPC')
legend([hcpwsc hcpwpec hcpwt],{'CPW Sc Al','CPW PEC Al','Shorted CPW Theory'});
hold off
%% Calculation of the deltaF_0
deltaF  = x_intersect_sc./x_intersect_pec;
iterator_partial = 4:19;
alpha_c_alu =  1 - (deltaF.^2);
f2 = figure;

sizes_W = arrayfun( @(x) x.get_W, PPCs  );
plot(sizes_W(iterator_partial),alpha_c_alu(iterator_partial));
title("Kinetic inductance fraction for different PPC Area's")
xlabel('W [m]')
ylabel('\alpha_{c,Alu}')
%ylim([0 0.2])


%% Making fit for f(F_0)= W -> f_fit(F_0) = W
f_fit_parameters = polyfit(x_intersect_sc(plot_iterator),sizes_W(plot_iterator),3);
f_fit = polyval(f_fit_parameters, x_intersect_sc(plot_iterator));
f4 = figure;
hold on
plot(x_intersect_sc(plot_iterator),sizes_W(plot_iterator));
plot(x_intersect_sc(plot_iterator),f_fit);
legend('Sonnet data f(F_{0}) = W','W = f_{fit}(F_{0}) = '+string(f_fit_parameters(1))+'x^{3}'+string(f_fit_parameters(2))+'x^{2}'+string(f_fit_parameters(3))+'x^{1}'+string(f_fit_parameters(1)));
hold off 
xlabel('Freq [Hz]');
ylabel('Width PPC [m]');
title('Relation between F_{0} and Width PPC');

%% Comparison Old and new data and theory.
PPCs_newdata = PPC_sonnet_oneport(50E-6,50E-6,250E-9,'PPCV0_9_9_compareA2500',9);
f5 = figure;hold on; plot(freq,-imag(PPCs(9).get_Zin()))
%plot(freq,-imag(PPCs_newdata.get_Zin()));
plot(freq,-imag(PPCt(9).get_Zin(freq)));
%legend('Old data Non-square','Square','Theory')
title('Comparison between old data new data and theory for 50\mu m x 50\mu m = 2500um^{2}')
xlabel('[Hz]')
ylabel('Im(Z_{in}) [\Omega]')
xlim([1E9 9E9]);
ylim([0 75]);
