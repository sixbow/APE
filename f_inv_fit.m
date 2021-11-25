function Area = f_inv_fit(a,b,F0,baseunits)
%Inverse of the f(A)= e^{b}A^{a}
%Yiels   f^{inv}(F_{0}) = \frac{e^{-\frac{b}{a}}}{F_{0}^{-\frac{1}{a}}}
if baseunits == true
    Area = exp(-b/a)/(F0^(-1/a));
elseif baseunits == false
    Area = (10^(-(1/a)*(-9-(12*a)+log10(exp(b)))))/(F0^(-1/a));
else
msg = 'Non allowed baseunits. baseunits must be Boolean!';
error(msg)
end
end

