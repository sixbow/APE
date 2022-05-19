function Appc = calclsideppc_inv(lsidePPC,lengthMSL,widthMSL,lengthMSL2,widthMSL2)
% Inverse of calcsideppc
Appc = lsidePPC.^2 + lengthMSL.*widthMSL + lengthMSL2*widthMSL2;
end

