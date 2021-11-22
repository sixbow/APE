clc
close all 


h1=plot([1:10],'Color','r','DisplayName','This one');hold on;
h2=plot([1:2:10],'Color','b','DisplayName','This two');
h3=plot([1:3:10],'Color','k','DisplayName','This three');
legend([h1 h3],{'Legend 1','Legend 3'})