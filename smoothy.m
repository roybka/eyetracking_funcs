function out = smoothy( signal,winlen)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin<3
    hamm=1;
end
l=length(signal);

c=[];
windStart=1;

for iPoint=1:length(signal)-winlen
windStart=windStart+1;
windInds=[windStart:windStart+winlen-1];

c(iPoint)=mean(signal(windInds));

out=[zeros(1,floor(winlen/2)), c ,zeros(1,ceil(winlen/2))];

end

