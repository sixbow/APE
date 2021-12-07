%clc
close all 
%clear
tic
%clear all %clear classes % Increasingly strong statements about clearing
%everything
% Parameters
Z0 = 79.605;%[Ohm] --> value from CPW simulation sonnet. varies only slightly as function of freq <0.1%
Z0_PEC =65.3696 ;%%[Ohm] --> value from CPW simulation sonnet. varies only slightly as function of freq <3ppm
epsilon_eff = 10.6008;%[-] --> value from CPW simulation sonnet. varies only slightly as function of freq <0.1%
epsilon_eff_PEC = 7.1484;%[-] --> value from CPW simulation sonnet. varies only slightly as function of freq <0.1%
epsilon0 = 8.854187E-12;% [C/m]
length_M = 0.001;%[m]
d = 250E-9;%[m]

%Data path
addpath('.\Sonnet_data')
filename_begin = 'PPCV0_9_9A';
filename_end = '.csv';
filename_CPW_SC = 'AlHybridV0_0_3_SC.csv';
filename_CPW_PEC = 'AlHybridV0_0_3_PEC.csv';
%% Loading Data and making objects.

A_filename_umsquared = [12710,10056,8320,7094,6184,5480,4920,4464,4086,3766,3493,3257,3051,2869,2708,2564,2434,2317,2211,2114];
A_ppc = A_filename_umsquared.*((1E-6)^2);

%5Target Toy model data validation
F0_5Target = [5.86083 5.5316 5.33138 4.72955 4.01304 3.10839].*10^9;
PPC_To_be_squared = [47.0213 50 52.0384 59.1016 70.1727 91.214].*10^(-6);
A_ppc_5Target = PPC_To_be_squared.*PPC_To_be_squared;
% Jochem Code data
F0_Jochem = [2310621857.66901,2594151197.17164,2848091619.57189,3080193995.21574,3294570175.75902,3495048293.57827,3683595761.38946,3861932630.02850,4031177778.48288,4193284041.57368,4348211285.19556,4496947156.08466,4640060715.25595,4778557898.03422,4911996912.86868,5041319369.84867,5167282193.70940,5289103153.16627,5407241595.85572,5522580077.27439];
A_ppc;



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
CPWtSC = CPW_theory(length_M,Z0,epsilon_eff);
CPWtPEC = CPW_theory(length_M,Z0_PEC,epsilon_eff_PEC);
CPWsSC = CPW_sonnet_oneport(2E-6,2E-6,length_M,filename_CPW_SC,9);
CPWsPEC = CPW_sonnet_oneport(2E-6,2E-6,length_M,filename_CPW_PEC,9);

%% Analyse data. Finding the intersects between CPW and PPC curves.
%Disp graph for the input impedance 
freq = PPCs.get_freq();
f1 = figure;
hold on
hcpwsc = sweetplot(CPWsSC.get_freq(),imag(CPWsSC.get_Zin));
hcpwpec = sweetplot(CPWsPEC.get_freq(),imag(CPWsPEC.get_Zin));
hcpwt = plot(freq,imag(CPWtSC.get_Zin(freq)),'--','linewidth',2);
hcpwt_PEC = plot(freq,imag(CPWtPEC.get_Zin(freq)),'--','linewidth',2);
plot_iterator = iterator;
for i=plot_iterator
    ht(i) = plot(freq,-imag(PPCt(i).get_Zin(freq)),'--');
    hts(i) = plot(freq,-imag(PPCs(i).get_Zin()));
    [x_intersect_sc(i),y_intersect_sc(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsSC.get_freq(),-imag(PPCs(i).get_Zin()),imag(CPWsSC.get_Zin()),'linearinterp',0);
    [x_intersect_pec(i),y_intersect_pec(i)] = find_intersect_2lines(PPCs(i).get_freq(),CPWsPEC.get_freq(),-imag(PPCs(i).get_Zin()),imag(CPWsPEC.get_Zin()),'linearinterp',0);
    [x_intersect_sc_t(i),y_intersect_sc_t(i)] = find_intersect_2lines(freq,freq,-imag(PPCt(i).get_Zin(freq)),imag(CPWtSC.get_Zin(freq)),'linearinterp',0);
    [x_intersect_pec_t(i),y_intersect_pec_t(i)] = find_intersect_2lines(freq,freq,-imag(PPCt(i).get_Zin(freq)),imag(CPWtPEC.get_Zin(freq)),'linearinterp',0);
    %normalizedtextarrow(gca(),[8.9E9 -imag(PPCs(i).get_Zin(4000))],[(freq(4000)) -imag(PPCs(i).get_Zin(4000))],string(PPCs(i).get_W()*1E6*50))
    set(gca,'FontSize',20);
end
hisc = plot(x_intersect_sc(plot_iterator),y_intersect_sc(plot_iterator),'o');
hipec = plot(x_intersect_pec(plot_iterator),y_intersect_pec(plot_iterator),'o');
hitsc = plot(x_intersect_sc_t(plot_iterator),y_intersect_sc_t(plot_iterator),'x');
hitpec = plot(x_intersect_pec_t(plot_iterator),y_intersect_pec_t(plot_iterator),'x');



xlabel('[Hz]')
ylabel('Im(Z_{in}) [\Omega]')
title('PPC and CPW input impedance')
xlim([1E9 9E9]);
ylim([0 50]); 
normalizedtextarrow(gca(),[(freq(3000)-1E9) -imag(PPCt(15).get_Zin(freq(3000)))],[(freq(3000)) -imag(PPCt(15).get_Zin(freq(3000)))],'Theory')% This needs some shaving to get at the right place!
normalizedtextarrow(gca(),[(freq(3400)-1E9) -imag(PPCs(15).get_Zin(3400))],[(freq(3400)) -imag(PPCs(15).get_Zin(3400))],'Sonnet PPC')
legend([hcpwsc hcpwpec hcpwt hcpwt_PEC],{'CPW Sc Al','CPW PEC Al','SC: Shorted CPW Theory','PEC: Shorted CPW Theory'});
hold off
%% Calculation of the deltaF_0
iterator_partial = iterator;
alpha_c_alu =  kindfrac(x_intersect_sc,x_intersect_pec);
alpha_c_alu_t =  kindfrac(x_intersect_sc_t,x_intersect_pec_t);
%Now we add 1 point of data for the Toy_Model Origin2500 and Origin2500PEC
% In order to get 1 data Point.
alpha_c_alu_Origin2500 = kindfrac(5.5316,6.72285);



f2 = figure;
hold on 
sizes_W = arrayfun( @(x) x.get_W, PPCs  );
sizes_H = arrayfun( @(x) x.get_H, PPCs );
sizes_A = sizes_W(iterator_partial).*sizes_H(iterator_partial);
sizes_W_t = arrayfun( @(x) x.get_W, PPCt  );
sizes_H_t = arrayfun( @(x) x.get_H, PPCt );
sizes_A_t = sizes_W_t(iterator_partial).*sizes_H_t(iterator_partial);
plot(sizes_A,alpha_c_alu(iterator_partial),'LineWidth',2);
plot(sizes_A_t,alpha_c_alu_t(iterator_partial),'--','LineWidth',2);
plot(2500E-12,alpha_c_alu_Origin2500,'+','LineWidth',2);
title("Kinetic inductance fraction for different PPC Area's")
ylim([0.3 0.35])
legend('Sonnet data','2Part model','Full Sonnet')
xlabel('W [m]')
ylabel('\alpha_{c,Alu}')
hold off
%ylim([0 0.2])


%% fitting F0=C*A^k by fitting in log log space.
sizes_A = sizes_W(plot_iterator).*sizes_H(plot_iterator);

[f5,hpower, a , b , str_formula] = powerlaw_fit(sizes_A,x_intersect_sc(plot_iterator));
figure(f5)
conv_iter = 1:10;% this makes sure the theory is run 10 times to make it converge to the actual value.
f_start =1E9;
f = f_start;
%F0_out =  zeros(length(iterator));
F0 = zeros(length(conv_iter));
for j=iterator
    for i=conv_iter
    F0(i) = F0_theory(f,0.001,A_ppc(j),Z0,epsilon_eff,d);%F0 = F0_theory(freq[Hz],lenght_CPW[m],AreaPPC[m^2],Z0[Ohm],epsilon_eff[-],d[m])
    err = (F0(i)-f)./F0(i);
    f = (F0(i)+f)/2;% in this piece of the code  we make a new guess using the formula averaged with the previous guess in order to converge into the final value.
    end
F0_out(j) = F0(length(conv_iter));
end
hold on
plot(sizes_A,x_intersect_sc_t,'--','linewidth',2);
plot(A_ppc,F0_out,'-.','linewidth',2)
h5Target = plot(A_ppc_5Target,F0_5Target,'+');
h5Target.MarkerSize = 10;
h5Target.LineWidth = 2;
hJochem = plot(A_ppc,F0_Jochem);
hJochem.MarkerSize = 10;
hJochem.LineWidth = 2;
legend('Sonnet data',str_formula,'Theory','Symbolic: ABCD-theory','Full Sonnet','Jochem code');
title('Sonnet data vs Power law vs ABCD-theory');
grid on 
grid minor
hold off

%% Responsivity calculation.
%[Alu.sigma1,Alu.sigma2,Alu.ds1dn,Alu.ds2dn]= Sigmas(2*pi*KID.Fres, Alu.N0, Alu.Delta, Alu.Teff);      %MB equations, vaklkid for T<<Tc, F<<Fgap
%for i=iterator
%[dthetadN(i),dRdN(i),dxdN(i),abssigma(i),Qi(i),Q(i),Beta(i)] = getresponsivity2(length_M,alpha_c_alu(i),20000,length_M*30e-9*2e-6,sigma1,sigma2,ds1dn,ds2dn,30e-9,Qim)
%end

%% g(A_coupler) =  Q_coupler
UNIT_Coupler_sonnet_class();
%Making objects for the Coupler data
filename_coupler = 'Coupler_FullDielectricV0_5_0Oeff';
iterator_coupler = 1:20;
for i=iterator_coupler
    Couplers(i) = Coupler_sonnet(4E-6,i*10^(-6),250E-9,filename_coupler+string(i)+filename_end,15);
end
fcoupler = figure;
hold on 
X_Area = [];
Y_Qc = [];
index_freq = 4000;
for i=iterator_coupler
   X_Area = [ X_Area, Couplers(i).Oeff]
   Y_Qc = [Y_Qc Couplers(i).get_Qc(index_freq)] 
end
hcoupler(i) = plot(X_Area,Y_Qc,'LineWidth',3);
xlabel('Oeff [m]')
ylabel('Qc [-]')
title('Qc vs Oeff for freq='+string(Couplers(1).get_freq(index_freq)))




% Number of header lines 15






toc
