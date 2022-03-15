%This script is to calculate which values the PPC should have in order to
%be linear in the frequency domain. 

%Run main first!
A_base_tbs = sqrt(A_filename_umsquared) ;

A_base = round(A_base_tbs);

A_filename_umsquared_new = A_base.*A_base;

