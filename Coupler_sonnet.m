classdef Coupler_sonnet
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Wcoupler
        Oeff
        d
        Qc
        Area
        data
        S11
        S12
        S13
        S21
        S22
        S23
        S31
        S32
        S33
        freq
    end
    
    methods
        function obj = Coupler_sonnet(Wcoupler,Oeff,d,LengthCorrection,data_str,hlines)
            %Coupler_sonnet(Width,Oeff,d,data_str,hlines) Construct an instance of this class
            % You need to give the Width[m] , the effective overlap with the
            % readout line denoted by Oeff[m] , thickness of the dielectric
            % d and data path to the csv document by data_str , and the
            % amount of header lines by hlines.
            obj.Wcoupler = Wcoupler; 
            obj.Oeff = Oeff; 
            obj.d = d;
            obj.data = table2array(readtable(data_str , "NumHeaderLines",hlines));
            obj.freq = obj.data(:,1)*10^9;
            obj.S11      = obj.data(:,2) + 1j*obj.data(:,3);
            obj.S12      = obj.data(:,4) + 1j*obj.data(:,5);
            obj.S13      = obj.data(:,6) + 1j*obj.data(:,7);
            obj.S21      = obj.data(:,8) + 1j*obj.data(:,9);
            obj.S22      = obj.data(:,10) + 1j*obj.data(:,11);
            obj.S23      = obj.data(:,12) + 1j*obj.data(:,13);
            obj.S31      = obj.data(:,14) + 1j*obj.data(:,15);
            obj.S32      = obj.data(:,16) + 1j*obj.data(:,17);
            obj.S33      = obj.data(:,18) + 1j*obj.data(:,19);
            obj.Qc = (LengthCorrection.*pi)./(2*(abs(obj.S13).^2));%Correction due to the discussion with alejandro.
            obj.Area = Wcoupler*Oeff;
            
            
            
            
            
            
            
            
        end
        
        function outputArg = get_Qc(obj,varargin)
            %Getter for Quality factor coupler.
            if length(varargin) == 0 
            outputArg = obj.Qc;
            else
            index = varargin(1);
            %disp(round(double(index{1,1})));
            outputArg = obj.Qc(cell2mat(index));
            end
        end
        function outputArg = get_freq(obj,varargin)
            %Getter for frequency.
            if length(varargin) == 0 
            outputArg = obj.freq;
            else
            index = varargin(1);
            %disp(round(double(index{1,1})));
            outputArg = obj.freq(cell2mat(index));
            end
        end
        function outputArg = get_Area(obj,varargin)
            %Getter for area.
            if length(varargin) == 0 
            outputArg = obj.Area;
            else
            index = varargin(1);
            %disp(round(double(index{1,1})));
            outputArg = obj.Area(cell2mat(index));
            end    
        end
        function outputArg = get_Oeff(obj,varargin)
            %Getter for area.
            if length(varargin) == 0 
            outputArg = obj.Oeff;
            else
            index = varargin(1);
            disp('Only has one value! You should not give an argument');
            end    
        end
    end
end

