function [f,hpower, a , b , formula_string] = powerlaw_fit(x_normal,y_normal,varargin)
%Fits a line in log log space -> indicative of power law
% Gives back handle to figure and coof a and b in the following formula
% f(A) = exp(b)*A^(a)
nVarargs = length(varargin);

if nVarargs == 0
f = figure;
hold on
hpower(1) = plot(x_normal,y_normal,'linewidth',2); % Plotting of the original data
log_fit = polyfit(log(x_normal), log(y_normal),1);
%Fitting with f(x)= ax +b
a = log_fit(1);
b = log_fit(2);% Indices are numbered other way around because of n series polynominal
hpower(2) = plot(x_normal, exp(b).*(x_normal.^a),'--','linewidth',2); % Plotting of the fitted power law
formula_string = 'f(A) = e^{'+string(b)+'}\cdot A^{'+string(a)+'}';
xlabel('area [m^{2}]')
ylabel('F_{0} [Hz]')
legend('Sonnet 2Part data','Power law')
hold off
else       
% If 'Surpressed' is given as input the plot will be surpressed.
f = 0;
hpower = 0;
log_fit = polyfit(log(x_normal), log(y_normal),1);
%Fitting with f(x)= ax +b
a = log_fit(1);
b = log_fit(2);% Indices are numbered other way around because of n series polynominal
formula_string = 'f(A) = e^{'+string(b)+'}\cdot A^{'+string(a)+'}';
end
end
