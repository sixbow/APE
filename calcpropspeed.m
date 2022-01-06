function v_p = calcpropspeed(epsilon_eff,Speed_of_light)
%calcpropspeed(epsilon_eff,Speed_of_light) input is the epsilon effective and c. Ouput is the
%propagation speed through the CPW line

v_p = (1/sqrt(epsilon_eff))*Speed_of_light;
end

