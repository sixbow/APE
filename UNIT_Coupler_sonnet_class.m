function UNIT_Coupler_sonnet_class()
%UNIT_Coupler_sonnet_class() is a unit test for the coupler sonnet class
% The result of this is eiter pass or fail
disp('Unit Test:Coupler_sonnet_class')
disp('------------------------------')
%% Using the constructor to create the object
testcounter = 0;
testpassedcounter = 0;
disp('Using the constructor to create the object')
test = Coupler_sonnet(4E-6,0,250E-9,2.554,'Coupler_FullDielectricV0_5_0Oeff0.csv',15);
disp('Passed')
testcounter = testcounter + 1;
testpassedcounter = testpassedcounter +1;

%% Getting all Qc values
testans = test.get_Qc();
testcounter = testcounter + 1;
disp('Getting all Qc values')
if length(testans) == 8001
    disp('Passed')
    testpassedcounter = testpassedcounter +1;
else 
    disp('Failed')
    
end

%% Getting a single value from Qc
testans = test.get_Qc(500);
testcounter = testcounter + 1;
disp('Getting a single value from Qc')
if length(testans) == 1
    disp('Passed')
    testpassedcounter = testpassedcounter +1;
else 
    disp('Failed')
    
end
disp('Passed in total: '+string(testpassedcounter)+'/'+string(testcounter))
clear test
disp('------------------------------')
end
