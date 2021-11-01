classdef PPC_sonnet
    %PPC_sonnet is a class that contains infomation about sonnet simulation
    %of the PPC
    %Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),)
    %Properties: d, e_r, N, W, C_PPC, e_0, A_coupler
    
    properties
        W
        N
        d
        data_dir
        omega
        Zin
        S11
        A_narrow_section= (4E-6)*(6E-6);
    end
    
        methods
        function obj = PPC_sonnet(W,N,d,data_dir)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

