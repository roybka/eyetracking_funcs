function [ r,p ] = nancorr( a,b )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
q=isnan(a)|isnan(b);
[r,p]=corr(a(~q),b(~q));

disp(['number of nans' num2str(sum(q))])


end

