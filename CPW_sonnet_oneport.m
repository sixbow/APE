classdef CPW_sonnet_oneport
    %PPC_sonnet is a class that contains infomation about sonnet simulation
    %of the PPC
    %Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),)
    %Properties: d, e_r, N, W, C_PPC, e_0, A_coupler
    
    properties
        S
        W
        M
        data_str
        data
        freq
        Zin
        S11
        %A_narrow_section= (4E-6)*(6E-6);
    end
    
        methods
        function obj = CPW_sonnet_oneport(S,W,M,data_str,hlines)
            %Constructor:  CPW_sonnet_oneport(S (width signal line[m]),W(width void [m]),M(Length CPW[m]),data_str(data string),hlines)
            % 
            obj.S        = S;
            obj.W        = W;
            obj.M        = M;
            obj.data_str = data_str;
            obj.data     = table2array(readtable(obj.data_str , "NumHeaderLines",hlines));
            obj.freq    = obj.data(:,1)*10^9;
            obj.Zin      = obj.data(:,2) + 1j*obj.data(:,3);
            %obj.genSparameter();
            
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
        %end Getters
    end
end

