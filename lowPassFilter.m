function lowPassFilter=lowPassFilter(high,signal,rate)
lowpass =high;
if nargin < 3
    rate = 1024;
    warndlg(['assuming sampling rate of ' num2str(rate)])
end

% [nlow,Wnlow]=buttord((0.5*lowpass)/(0.5*rate), lowpass/(0.5*rate) , 0.01, 24);
[nlow,Wnlow]=buttord( lowpass/(0.5*rate), 2*lowpass/(0.5*rate) , 3, 24); % Alon 27.1.09: changed so that high is the cuttoff freq of -3dB 
%disp(['Wnlow = ' num2str(Wnlow)]);
% [nlow,Wnlow]=buttord((0.5*lowpass)/(0.5*rate), lowpass/(0.5*rate) , 10, 18)

[b,a] = butter(nlow,Wnlow,'low') ;
lowPassFilter = filtfilt(b,a,signal);
%figure; plot(signal); hold on;
%plot(bandPassFilter);
end