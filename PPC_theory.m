classdef PPC_theory
   
    %PPC_theory is a class that contains infomation about theoretical PPC
    %Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),e_r(number))
    %PropertiesL d, e_r, N, W, C_PPC_theory, e_0, A_coupler
    
    properties
        d
        e_r
        N
        W 
        C_PPC_theory
        e_0 = 8.854E-12;
        A_narrow_section= (4E-6)*(6E-6);
    end
        
    methods
        %Constructors:
        function obj = PPC_theory(W,N,d,e_r)
            %PPC Construct an instance of this class
            %   Detailed explanation goes here
            if  nargin > 0
                obj.W = W;
                obj.N = N;
                obj.d = d;
                obj.e_r = e_r;
                obj.C_PPC_theory = (obj.e_0*obj.e_r*(obj.N*obj.W))/(obj.d);
            end   
        end
        %End Constructors
        
        %General useful methods:
        function outputArg = get_Zin(obj,freq)
        %Zin calculates input impedance according to Zin=-j/(omega*C)
        outputArg = -1i.*(1./(2*pi*freq.*obj.C_PPC_theory));
        end
        function outputArg = get_A(obj)
            %get_C_PPC_theory() :  getter total surface area + small overlap PPC
            outputArg = obj.A_narrow_section + obj.N*obj.W;
        end 
        %End General useful methods
        
        %Getters!
        function outputArg = get_d(obj)
            %get_C_PPC_theory() :  getter for thickness of PPC
            outputArg = obj.d;
        end 
        function outputArg = get_e_r(obj)
            %get_C_PPC_theory() :  getter for relative permitivity
            outputArg = obj.e_r;
        end 
        function outputArg = get_N(obj)
            %get_C_PPC_theory() :  getter for Length PPC
            outputArg = obj.N;
        end 
        function outputArg = get_W(obj)
            %get_C_PPC_theory() :  getter for Width PPC
            outputArg = obj.W;
        end
        function outputArg = get_C_PPC_theory(obj)
            %get_C_PPC_theory() :  getter for Theoretical capacitance value PPC
            outputArg = obj.C_PPC_theory;
        end 
        function outputArg = get_e_0(obj)
            %get_C_PPC_theory() :  getter for epsilon naught.
            outputArg = obj.e_0;
        end 
        function outputArg = get_A_coupler(obj)
            %get_C_PPC_theory() :  getter for narrow section PPC
            outputArg = obj.A_narrow_section;
        end 
        %End Getters
        
    end%end methods
end% End class PPC_theory

