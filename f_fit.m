function F0 = f_fit(a,b,Area ,baseunits)
% f_fit(a(double),b(double),Area(double),baseunits(string:'native' or 'base')
% f(A)= e^{b}A^{a}
% This relation relates the Area of the PPC to the resonance frequency in
% case of 1mm CPW of the 2-2-2 type used in DESHIMA 2.0
% where a and b are the coof from the log-log fit of Area vs freq. 
if nargin<3
    error('a,b,Area are required arguments for function to function')
end
if nargin<4
    baseunits = 'base';
end
if strcmp(baseunits,'base')
    F0 = exp(b)*(Area^(a));
elseif strcmp(baseunits,'native')
    F0 = 10^(log10(exp(b))-12*a-9 )*Area^a;
else
msg = "Non allowed baseunits. baseunits chooser must be 'base'(m|Hz) or 'native'(um|GHz) !";
error(msg)
end
end
