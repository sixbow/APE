function Appc = calclsideppc_inv(lsidePPC,lengthMSL,widthMSL)
% Inverse of calcsideppc
Appc = lsidePPC.^2 + lengthMSL.*widthMSL;
end

