function output = calcround(input,fraction)
%calcround rounds input to the nearest fraction given in fraction.

output = round(input * (1/fraction))/(1/fraction);

end

