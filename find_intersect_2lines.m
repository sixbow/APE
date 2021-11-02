function [x_intersect,y_intersect] = find_intersect_2lines(xdata1,xdata2,ydata1,ydata2,fitt,plotyesno)
% Author: Jochem Baselmans
% [x_intersect,y_intersect] = find_intersect_2lines(xdata1,xdata2,ydata1,ydata2,fitt,plotyesno)
% find the intersects of datasets of xdata1,xdata2,ydata1,ydata2
% interpolates data using Matlab library fitType
% BECOMES UNRELIABLE UNLESS USING 'linearinterp'
% INPUT
% xdata1,xdata2,ydata1,ydata2 are all 1col vectors
% fitt = Matlab fitType
% 'poly1'   Linear polynomial curve
% 'poly2'   Quadratic polynomial curve
% 'linearinterp'     Piecewise linear interpolation
% 'cubicinterp'     Piecewise cubic interpolation
% 'smoothingspline'  Smoothing spline (curve) (bad for exponentials
% plotyesno = 0 or 1. use 1 to create a plot, 0 to suppress it
%
% catches intersects out of range
% OUTPUT
% x_intersect,y_intersect, both single values of the intersect point

if nargin == 4
    fitt = 'linearinterp';
    plotyesno = 0;
end
line1 = fit(xdata1,ydata1,fitt);
line2 = fit(xdata2,ydata2,fitt);

%find intersect
[x_intersect,~,exitflag] = fzero(@(x) feval(line2,x)-feval(line1,x),mean(xdata1));
if exitflag ~= 1
    error('Cannot find intersection of the requested lines in find_intersect_2lines.')
end
y_intersect = feval(line1,x_intersect);
if x_intersect > max(xdata1) || x_intersect > max(xdata2)
    x_intersect = NaN;y_intersect=NaN;
end
if plotyesno == 1
    plot(line1,'r');hold on;
    plot(line2,'b')
    plot(xdata1,ydata1,'r.');hold on;
    plot(xdata2,ydata2,'b.')
    plot(x_intersect,y_intersect,'ok','MarkerFaceColor','k','MarkerSize',8);hold on;
end
end