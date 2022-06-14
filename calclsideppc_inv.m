function Appc = calclsideppc_inv(lsidePPC,lengthMSL,widthMSL,lengthMSL2,widthMSL2)
% Inverse of calcsideppc Suggested values : (<User Value> ,20,4,6,4)
Appc = lsidePPC.^2 + lengthMSL.*widthMSL + lengthMSL2*widthMSL2;
end

