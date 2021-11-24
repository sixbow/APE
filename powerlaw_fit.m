function [f,hpower, a , b] = powerlaw_fit(x_normal,y_normal)
%Fits a line in log log space -> indicative of power law
% Gives back handle to figure and coof a and b in the following formula
% f(A) = exp(b)*A^(a)

f = figure;
hold on
hpower(1) = plot(x_normal,y_normal);
log_fit = polyfit(log(x_normal), log(y_normal),1);
%Fitting with f(x)= ax +b
a = log_fit(1);
b = log_fit(2);% Indices are numbered other way around because of n series polynominal
hpower(2) = plot(x_normal, exp(b).*(x_normal.^a),'--');
legend('Sonnet Data','f(A) = e^{'+string(b)+'}\cdot A^{'+string(a)+'}')
xlabel('area [m^{2}]')
ylabel('F_{0} [Hz]')
title('Sonnet data vs Power law');
hold off 
end

