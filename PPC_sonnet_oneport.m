classdef PPC_sonnet_oneport
    %PPC_sonnet is a class that contains infomation about sonnet simulation
    %of the PPC
    %Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),)
    %Properties: d, e_r, N, W, C_PPC, e_0, A_coupler
    
    properties
        W
        N
        d
        data_str
        data
        freq
        Zin
        S11
        %A_narrow_section= (4E-6)*(6E-6);
    end
    
        methods
        function obj = PPC_sonnet_oneport(W,N,d,data_str,hlines)
            %Constructor for the PPC_sonnet_oneport class 
            % PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir,hlines)   
            if nargin > 0 % Way to implement function overloading in MATLAB. Want to have empty constructor to allocate objects.
            obj.W        = W;
            obj.N        = N;
            obj.d        = d;
            obj.data_str = data_str;
            obj.data     = table2array(readtable(obj.data_str , "NumHeaderLines",hlines));
            obj.freq    = obj.data(:,1)*10^9;
            obj.Zin      = obj.data(:,2) + 1j*obj.data(:,3);
            %obj.genSparameter();% NEED: function to convert Z -> S-param
            end
        end
        
        
        
        %Getters:
        function outputArg = get_freq(obj)
            %Getter for frequency
            outputArg = obj.freq;
        end
        function outputArg = get_Zin(obj)
            %Getter for complex input impedance.
            outputArg = obj.Zin;
        end
        function outputArg = get_W(obj)
            %Getter for complex input impedance.
            outputArg = obj.W;
        end
        %end Getters
    end
end

