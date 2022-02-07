function Qout = calcQadd(Q1,Q2)
%calcQpar calculates the combination of 2 Q factors by means of the
%parrallel formula

Qout = (Q1.*Q2)/(Q1+Q2);
end

