function theta = theta(epsilon_eff,freq,l)
%theta =  theta(epsilon_eff,freq)
c = 299792458;% [m/s]
theta = 2*pi*((sqrt(epsilon_eff)*freq)/c)*l;
end

