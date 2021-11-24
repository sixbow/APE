classdef PPC_sonnet_oneport
    %PPC_sonnet is a class that contains infomation about sonnet simulation
    %of the PPC
    %Constructor arg: PPC_theory(W (Width PPC(m)),N (Lenght PPC(m)),d (thickness dielectric(m)),)
    %Properties: d, e_r, N, W, C_PPC, e_0, A_coupler
    
    properties
        W
        H
        d
        data_str
        data
        freq
        Zin
        S11
        %A_narrow_section= (4E-6)*(6E-6);
    end
    
        methods
        function obj = PPC_sonnet_oneport(W,H,d,data_str,hlines)
            %Constructor for the PPC_sonnet_oneport class 
            % PPC_sonnet_oneport(Width(m),N Length(m),d thickness(m),data_dir,hlines)   
            if nargin > 0 % Way to implement function overloading in MATLAB. Want to have empty constructor to allocate objects.
            obj.W        = W;
            obj.H        = H;
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
        function Zin_for_index = get_Zin_for_index(obj,index)
            Zin_for_index = obj.Zin(index);
        end
        function outputArg = get_Zin(obj,varargin)
            %Getter for complex input impedance.
            if length(varargin) == 0 
            outputArg = obj.Zin;
            else
            index = varargin(1);
            %disp(round(double(index{1,1})));
            outputArg = obj.Zin(cell2mat(index));
            end
        end
        function outputArg = get_W(obj)
            %Getter for width
            outputArg = obj.W;
        end
        function outputArg = get_H(obj)
            % Getter for Length of the PPC
            outputArg = obj.H;
        end 
        %end Getters
    end
end

