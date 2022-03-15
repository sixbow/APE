function lsidePPC = calclsideppc(Area_12CKID,lengthMSL,widthMSL)
%lsidePPC = calclsideppc(Area_12CKID,lengthMSL,widthMSL)
% Calculates the length of the sides of the Parralell plate capacitor (PPC)
% You need to give the Area that is needed. The length and the width of the
% Microstripline(MSL) connecting the PPC to the Throughline(TL)/Readout
% line.
lsidePPC = sqrt(Area_12CKID-(lengthMSL*widthMSL));
end

