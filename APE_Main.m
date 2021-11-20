clc
close all 
clear

%clear all %clear classes % Increasingly strong statements about clearing
%everything

%Data path
addpath('.\Sonnet_data')
filename_begin = 'PPCV0_0_3W';
filename_end = '.csv';
filename_CPW_SC = 'AlHybridV0_0_3_SC.csv';
filename_CPW_PEC = 'AlHybridV0_0_3_PEC.csv';
%% Loading Data and making objects.
iterator = 1:19;
size_step_W = 5E-6;
begin_size_W = 10E-6;
size_namestep_W = 5;
begin_name_W = 10;
%Constructs the PPC theory  and PPC sonnet objects.
PPCt = repmat(PPC_theory(),1,length(iterator));% convoluded way of preallocating an array of the objects
PPCs = repmat(PPC_sonnet_oneport(),1,length(iterator));% convoluded way of preallocating an array of the objects
for i=iterator
    %Constructor arg: PPC_theory(W (Width PPC(m)),H (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
    PPCt(i) = PPC_theory(size_step_W*(i-1)+begin_size_W,50E-6,250E-9,10);
    total_filename = filename_begin+string((i-1)*size_namestep_W+begin_name_W)+filename_end;
    % PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir)
    PPCs(i) = PPC_sonnet_oneport(size_step_W*(i-1)+begin_size_W,50E-6,250E-9,total_filename,8);
end
PPCte = repmat(PPC_theory(),1,length(iterator));% convoluded way of preallocating an array of the objects
for i=iterator
    %Extending the theoretical PPC lines to higher width values by creating these extended objects
    PPCte(i) = PPC_theory(size_step_W*(i-1)+100E-6,50E-6,250E-9,10);
end

% Constructs the CPW objects.
CPWt = CPW_theory_first_order(0.001,1.099E-9);
CPWsSC = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_SC,9);
CPWsPEC = CPW_sonnet_oneport(2E-6,2E-6,0.001,filename_CPW_PEC,9);

%% Analyse data. Finding the intersects between CPW and PPC curves.
%Disp graph for the input impedance 
freq = PPCs.get_freq();
f = figure;
hold on
plot_iterator = 3:19;
for i=plot_iterator
    plot(freq,-imag(PPCt(i).Zin(freq)));
    plot(freq,-imag(PPCte(i).Zin(freq)),':');% Extended theoretical lines
    plot(freq,-imag(PPCs(i).get_Zin()));
    [x_intersect_sc(i),y_intersect_sc(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsSC.get_freq(),-imag(PPCs(i).Zin()),imag(CPWsSC.Zin()),'linearinterp',0);
    [x_intersect_pec(i),y_intersect_pec(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsPEC.get_freq(),-imag(PPCs(i).Zin()),imag(CPWsPEC.Zin()),'linearinterp',0);
end
%% Plotting..
plot(x_intersect_sc(plot_iterator),y_intersect_sc(plot_iterator),'o')
plot(x_intersect_pec(plot_iterator),y_intersect_pec(plot_iterator),'o')
plot(freq,imag(CPWt.Zin(freq)));
sweetplot(CPWsSC.get_freq(),imag(CPWsSC.get_Zin))
sweetplot(CPWsPEC.get_freq(),imag(CPWsPEC.get_Zin))
%legend('PPC Theory','Sonnet','CPW Theory')
xlabel('[Hz]')
ylabel('Im(Z_{in}) [\Omega]')
title('PPC and CPW input impedance')
xlim([1E9 9E9]);
ylim([0 75]);
normalizedtextarrow(gca(),[5e9 60],[6e9 60],'Fout:Theory')% This needs some shaving to get at the right place!
normalizedtextarrow(gca(),[5e9 50],[6e9 50],'Fout:Sonnet PPC')

hold off
%% Calculation of the deltaF_0
deltaF  = x_intersect_sc./x_intersect_pec;
iterator_partial = 4:19;
alpha_c_alu =  1 - (deltaF.^2);
h2 = figure;

sizes_W = arrayfun( @(x) x.get_W, PPCs  );
plot(sizes_W(iterator_partial),alpha_c_alu(iterator_partial));
title("Kinetic inductance fraction for different PPC Area's")
xlabel('W [m]')
ylabel('\alpha_{c,Alu}')
%ylim([0 0.2])


%% Making fit for f(F_0)= W -> f_fit(F_0) = W
f_fit_parameters = polyfit(x_intersect_sc(plot_iterator),sizes_W(plot_iterator),3);
f_fit = polyval(f_fit_parameters, x_intersect_sc(plot_iterator));
h3 = figure;
hold on
plot(x_intersect_sc(plot_iterator),sizes_W(plot_iterator));
plot(x_intersect_sc(plot_iterator),f_fit);
legend('Sonnet data f(F_{0}) = W','W = f_{fit}(F_{0}) = '+string(f_fit_parameters(1))+'x^{3}'+string(f_fit_parameters(2))+'x^{2}'+string(f_fit_parameters(3))+'x^{1}'+string(f_fit_parameters(1)));
hold off 
xlabel('Freq [Hz]');
ylabel('Width PPC [m]');
title('Relation between F_{0} and Width PPC');

%% Making fit for g(Q_coupling)=Area_coupler -> g_fit(Q_c) = Area_c




