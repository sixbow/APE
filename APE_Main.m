clear all
close all 
%Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
PPC = PPC_theory(50E-6,50E-6,250E-9,10);
%Disp graph for the input impedance
omega = linspace(3E9,7E9,100);
plot(omega,imag(PPC.Zin(omega)))


