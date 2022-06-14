function lsidePPC = calclsideppc(Area_12CKID,lengthMSL,widthMSL,lengthMSL2,widthMSL2)
%lsidePPC = calclsideppc(Area_12CKID,lengthMSL,widthMSL)
% Suggested values : (<User Value> ,20,4,6,4)
% Calculates the length of the sides of the Parralell plate capacitor (PPC)
% You need to give the Area that is needed. The length and the width of the
% Microstripline(MSL) connecting the PPC to the Throughline(TL)/Readout
% line.
%MSL2 is the far end of the PPC
lsidePPC = sqrt(Area_12CKID-(lengthMSL*widthMSL)-(lengthMSL2*widthMSL2));
end

