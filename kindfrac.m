function alpha_k = kindfrac(F0,F0_PEC)
%calc_kindfrac(F0,F0_PEC) calculates the kinetic induction fraction for
%either single input frequencies and for an array of inputs.
deltaF  = F0./F0_PEC;
alpha_k =  1 - (deltaF.^2);
end

