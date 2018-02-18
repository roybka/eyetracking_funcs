function [types, counts]=type_freq_4_EEGLAB(EEG)
types=[];
counts=[];
for i=1:length(EEG.event)
    if ~ismember(numOrStr2num( EEG.event(i).type),types))
        types={types ,{numOrStr2num(EEG.event(i).type)}};
        counts=[counts 1];
    else
       counts(types==numOrStr2num(EEG.event(i).type))= counts(types==EEG.event(i).type)+1;
    end
end
[types ind]=sort(types);
counts=counts(ind);