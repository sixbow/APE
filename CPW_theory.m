classdef CPW_theory
    %Class that describes the theory of the CPW hybrid section.
    % constructor has the following input arguments.
    % CPW_theory_first_order(M(lenght CPW),Z0,epsiloneff)
    
    properties
        M
        L
        Z0
        epsiloneff
    end
    
    methods
        function obj = CPW_theory(M,Z0,epsiloneff)
            %Constructor CPW_theory_first_order(M(lenght CPW),Z0[Ohm],epsiloneff[-])
            if nargin > 0 % Way to implement function overloading in MATLAB. Want to have empty constructor to allocate objects.
            obj.M = M;
            obj.epsiloneff = epsiloneff;
            obj.Z0 = Z0;
            end
        end
        
        function outputArg = get_Zin(obj,freq)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = 1i*obj.Z0*tan(theta(obj.epsiloneff,freq,obj.M));
        end
    end
end

