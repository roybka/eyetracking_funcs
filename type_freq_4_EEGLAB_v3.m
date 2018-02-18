function [types1]=type_freq_4_EEGLAB_v3(EEG)
% this version returns a categorical
types={};
for i=1:length(EEG.event)
    types{i}=EEG.event(i).type;
end
types1=categorical(types,'ordinal',true);
%summary(types1)