
freq = linspace(5.5E9,6E9,1000);
A_filename_umsquared = [12769,10000, 8281 ,7056, 6241, 5476, 4900, 4489, 4096, 3721, 3481, 3249, 3025, 2916, 2704, 2601, 2401, 2304, 2209, 2116];
A_ppc = A_filename_umsquared.*((1E-6)^2);


for i=1:length(freq)
    F0_out(i) = F0_theoryV2(freq(i),0.001,(58.5^2),7.8 , 79.725,10.633,295);
end

plot(freq,F0_out)
xlabel('F0 in')
ylabel('F0 out')
title('test numerical stability')
figure
hold on
plot(freq,(F0_out-freq))
plot(freq,zeros(1000))
xlabel('F0 in')
ylabel('F0 out')
title('test numerical stability - crossing point')
hold off 