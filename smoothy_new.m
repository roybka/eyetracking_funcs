function out = smoothy_new( signal,winlen)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin<3
    hamm=1;
end
l=length(signal);

c=[];end_c=[];
windStart=1;

for iPoint=1:length(signal)-winlen
windStart=windStart+1;
windInds=[windStart:windStart+winlen-1];

c(iPoint)=mean(signal(windInds));


end

for i=1:winlen/2
windInds=i:(winlen/2);
    start_c(i)=mean(signal(windInds));
end
cnt=0;
for i=(1+length(signal)-winlen/2):length(signal)
    cnt=cnt+1;
    windInds=i:length(signal);
    end_c(cnt)=mean(signal(windInds));
end
out=[start_c, c ,end_c];
length(start_c);
length(end_c);