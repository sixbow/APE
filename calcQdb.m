function Q = calcQdb(F3dbLeft, F0 , F3dbRight)
% calcQdb(FLeft, F0 , FRight) calculates the Q factor of the whole
% resonator via the most simple formula. Q = F0/BW
Q = F0/ (F3dbRight-F3dbLeft);
end

