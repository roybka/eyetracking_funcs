function [ eventbinvec ] = eventvecextract(EEG )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
eventbinvec=[];
for i=1:length(EEG.epoch)

    for j=1:length(EEG.epoch(i).eventbepoch)
        if length(EEG.epoch(i).eventbepoch)==1
            eventbinvec=[eventbinvec EEG.epoch(i).eventbini{j}];
        elseif (EEG.epoch(i).eventbepoch{j})~=0;
            eventbinvec=[eventbinvec EEG.epoch(i).eventbini{j}];
        end
    end
    
            
end

