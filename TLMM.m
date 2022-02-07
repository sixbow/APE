clc 
close all 
clear all 

%%Setup
addpath('.\Functions_TLMM')

%%User input
tlmm_Zload      = 0;       % [Ohm]

tlmm_freq_begin = 1E9;    % [Hz]
tlmm_freq_end   = 9E9;    % [Hz]
tlmm_freq_N     = 10000;
tlmm_freq = linspace(tlmm_freq_begin,tlmm_freq_end,tlmm_freq_N);

tlmm_Z0ref      = 50 ;     % [Ohm]


tlmm_CPWprop.eps_eff= 10.6009;% [-]
tlmm_CPWprop.Z0     = 76.28;  % [Ohm] % Caution!
tlmm_CPWprop.length = 0.0055;  % [m]

tlmm_PPCprop.Width  = 40E-6;  % [m]
tlmm_PPCprop.Height = 40E-6;  % [m]
tlmm_PPCprop.thickness= 250E-9;% [m]

tlmm_PPCprop.Area   = tlmm_PPCprop.Width*tlmm_PPCprop.Height;
tlmm_PPCprop.epsr   = 10   ;  % [-]
tlmm_PPCprop.C      = PPCAreatocap(tlmm_PPCprop.Area,tlmm_PPCprop.thickness,tlmm_PPCprop.epsr,'base'); % [F]


tlmm_MSLprop.eps_eff= 61.047;% [-]
tlmm_MSLprop.Z0     = 17.578;  % [Ohm]
tlmm_MSLprop.length = 20E-6;  % [m]

tlmm_Couplerprop.Width  = 4E-6;  % [m]
tlmm_Couplerprop.Height = 4E-6;  % [m]
tlmm_Couplerprop.thickness= 250E-9;% [m]


tlmm_Couplerprop.Area   = tlmm_Couplerprop.Width*tlmm_Couplerprop.Height;
tlmm_Couplerprop.epsr   = 10   ;  % [-]
tlmm_Couplerprop.C      = PPCAreatocap(tlmm_Couplerprop.Area,tlmm_Couplerprop.thickness,tlmm_Couplerprop.epsr,'base'); % [F]


tlmm_Throughlineprop.eps_eff= 7.9096;% [-]
tlmm_Throughlineprop.Z0     = 49.0504;  % [Ohm]
tlmm_Throughlineprop.length = 1; % [m] %Warning: This is kinda random at this moment

tlmm_CPW      =   zeros(2,2,tlmm_freq_N);
tlmm_PPC      =   zeros(2,2,tlmm_freq_N);
tlmm_MSL      =   zeros(2,2,tlmm_freq_N);
tlmm_Coupler  =   zeros(2,2,tlmm_freq_N);
tlmm_Sys      =   zeros(2,2,tlmm_freq_N);
tlmm_Zsys     =   zeros(2,2,tlmm_freq_N);
tlmm_Throughline =zeros(2,2,tlmm_freq_N);
tlmm_Sparameters =  zeros(2,2,tlmm_freq_N);
tlmm_Shunt    = zeros(2,2,tlmm_freq_N); 
tlmm_InThroughline = zeros(2,2,tlmm_freq_N); 
tlmm_Zin      = zeros(1,tlmm_freq_N);
tlmm_S21      = zeros(1,tlmm_freq_N);

for i = 1:length(tlmm_freq)
tlmm_CPW(:,:,i) =     tlmm_TL_ABCD(tlmm_freq(i),tlmm_CPWprop);
tlmm_PPC(:,:,i) =     tlmm_ParCAP_ABCD(tlmm_freq(i),tlmm_PPCprop);
tlmm_MSL(:,:,i) =     tlmm_TL_ABCD(tlmm_freq(i),tlmm_MSLprop);
tlmm_Coupler(:,:,i) = tlmm_SeriesCAP_ABCD(tlmm_freq(i),tlmm_Couplerprop);

%tlmm_Sys(:,:,i) = tlmm_Coupler(:,:,i)*tlmm_MSL(:,:,i)*tlmm_PPC(:,:,i)*tlmm_CPW(:,:,i);
tlmm_Sys(:,:,i) = tlmm_Coupler(:,:,i)*tlmm_CPW(:,:,i);
tlmm_Throughline(:,:,i) = tlmm_TL_ABCD(tlmm_freq(i),tlmm_Throughlineprop);
end % End of for loop for calculating matrices


tlmm_Zsys(:,:,i)   = abcd2z(tlmm_Sys(:,:,i));

for i = 1:length(tlmm_freq)
tlmm_Zin(i)   = tlmm_ZmatrixtoZin(tlmm_Sys(:,:,i),tlmm_Zload);
end % End of for loop for calculating matrices

for i = 1:length(tlmm_freq) 
tlmm_Shunt(:,:,i)        = tlmm_Shunt_ABCD(tlmm_Zin(i));
tlmm_InThroughline(:,:,i) = tlmm_Throughline(:,:,i)*tlmm_Shunt(:,:,i)*tlmm_Throughline(:,:,i);%Caution!! Removed the thoughline
end 

tlmm_Sparameters  = abcd2s(tlmm_InThroughline,tlmm_Z0ref);
for i = 1:length(tlmm_freq) 
tlmm_S21(i) = tlmm_Sparameters(2,1,i);
end 

%% Plotting


subplot(1,2,1)
plot(tlmm_freq,10*log10(abs(tlmm_S21)));
subplot(1,2,2)
plot(tlmm_freq,tlmm_Zin)

