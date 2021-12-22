function Area = f_inv_fit(a,b,F0,baseunits)
%Inverse of the f(A)= e^{b}A^{a}
%Yiels   f^{inv}(F_{0}) = \frac{e^{-\frac{b}{a}}}{F_{0}^{-\frac{1}{a}}}
if nargin<3
    error('a,b,Frequency are required arguments for function to function')
end
if nargin<4
    baseunits = 'base';
end
if strcmp(baseunits,'base')
    Area = exp(-b./a)./(F0.^(-1./a));
elseif strcmp(baseunits,'native')
    Area = (10.^(-(1./a).*(-9-(12.*a)+log10(exp(b)))))./(F0.^(-1./a));
else
msg = "Non allowed baseunits. baseunits chooser must be 'base'(m|Hz) or 'native'(um|GHz) !";
error(msg)
end
















end

