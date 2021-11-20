function normalizedtextarrow(inputaxes,xybegin,xyend,inputstring)
%normalizedtextarrow gives a normal text arrow with annotation in the data
%coordinates. normalizedtextarrow([beginx beginy] , [endx endy], textstring
%)
% Uses the publicly available code: sco1 (2021). coord2norm (https://github.com/StackOverflowMATLABchat/coordinate2normalized), GitHub. Retrieved November 20, 2021. 


x1 = xybegin(1,1);
y1 = xybegin(1,2);
x2 = xyend(1,1);
y2 = xyend(1,2);

[normx, normy] = coord2norm(inputaxes, [ x1 x2], [y1 y2]);
annotation('textarrow', normx, normy,'String',inputstring);

end

