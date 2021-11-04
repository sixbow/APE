classdef car < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        on
    end
    
    methods
        function obj = car(inputArg1)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.on = inputArg1 ;
        end
        
        function start(obj,var)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.on = var;
        end
    end
end

