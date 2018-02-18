function [types, counts]=type_freq_4_EEGLAB(EEG)
types={};
counts=[];
for i=1:length(EEG.event)
    if ~any(strcmp(EEG.event(i).type,types))
        types{length(types)+1}=EEG.event(i).type;
        counts=[counts 1];
    else
       counts(find(strcmpi( EEG.event(i).type,types)))= counts(find(strcmpi( EEG.event(i).type,types)))+1;
    end
end
[types ind]=sort(types);
counts=counts(ind);