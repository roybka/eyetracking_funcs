
for i=1:length(EEG.event)
    if strcmp(EEG.event(i).type,'R_saccade')
        EEG.event(i).type=201;
    elseif strcmp(EEG.event(i).type,'L_saccade')
        EEG.event(i).type=202;
    elseif strcmp(EEG.event(i).type,'R_fixation')
        EEG.event(i).type=203;    
    elseif strcmp(EEG.event(i).type,'L_fixation')
        EEG.event(i).type=204;
    elseif strcmp(EEG.event(i).type,'R_blink')
        EEG.event(i).type=205;
    elseif strcmp(EEG.event(i).type,'L_blink')
        EEG.event(i).type=206;
    end
end

for i=1:length(EEG.urevent)
    if strcmp(EEG.urevent(i).type,'R_saccade')
        EEG.urevent(i).type=201;
    elseif strcmp(EEG.urevent(i).type,'L_saccade')
        EEG.urevent(i).type=202;
    elseif strcmp(EEG.urevent(i).type,'R_fixation')
        EEG.urevent(i).type=203;    
    elseif strcmp(EEG.urevent(i).type,'L_fixation')
        EEG.urevent(i).type=204;
    elseif strcmp(EEG.urevent(i).type,'R_blink')
        EEG.urevent(i).type=205;
    elseif strcmp(EEG.urevent(i).type,'L_blink')
        EEG.urevent(i).type=206;
    end
end

for i=1:length(EEG.event)
    if ischar(EEG.event(i).type)
        EEG.event(i).type=str2num(EEG.event(i).type);
    end
end