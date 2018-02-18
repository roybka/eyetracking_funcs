function [ el ] = pix2deg( a,DPP )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
xypix=a.gazeCoords(3:4)
x=a.gaze.x;
y=a.gaze.y;
xindegs=(x-(xypix(1)/2))/(1/DPP);
yindegs=(y-(xypix(2)/2))/(1/DPP);
el=[xindegs;yindegs];
end

