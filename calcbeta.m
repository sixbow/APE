function beta = calcbeta(freq,epsilon_eff,Speed_of_light)
%calcbeta(freq, epsilon_eff,Speed_of_light)
beta = ((2*pi*freq)/calcpropspeed(epsilon_eff,Speed_of_light));
end

