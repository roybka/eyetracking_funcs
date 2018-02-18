
function [f, PSD] = get_PowerSpec_inRange(signal, SamplingRate)

p_spec = get_PowerSpec(signal) ;
amp = p_spec(1:ceil(length(p_spec)/2)) ;
 
f = SamplingRate*(1:length(amp))/(length(amp)*2);
PSD = amp(1:length(f));