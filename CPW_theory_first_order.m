classdef CPW_theory_first_order
    %Class that describes the theory of the CPW hybrid section.
    % constructor has the following input arguments.
    % CPW_theory_first_order(M(lenght CPW),L(Inductance in Henry))
    
    properties
        M
        L
    end
    
    methods
        function obj = CPW_theory_first_order(M,L)
            %Constructor CPW_theory_first_order(M(lenght CPW [m]),L(Inductance [Henry]))
            obj.M = M;
            obj.L = L;
        end
        
        function outputArg = Zin(obj,freq)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = 1i*2.*pi.*freq.*obj.L;
        end
    end
end

