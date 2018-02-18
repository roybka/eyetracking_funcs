function []=singletrialspect(EEG,trialnum,elect)
% this function plots a spectrogram of gamma frequency power of a single eeg trial.
%each (micro)saccade is easily seen in the specrum.
% it also plots the eye position relative to the spectrogram aligned to it.
%allows choice of trial number and electrode.
%works conveniently on raw EEGLAB data.
% 
%input:EEG-- 3d eeglab array (electrodes by datapoints by trials) , along with 
%               trialnum - requested single trial to plot
%               elect  - selected electrode

F=[30:1:90]; %frequencies in play
window=120; %window length
Noverlap=115; %num of overlapping samples
% X=(double(EEG.data(48,:,8)));
% %S = SPECTROGRAM(X,WINDOW,NOVERLAP,NFFT) 
%  [S,F,T,P] =SPECTROGRAM(X,[],[],F,1024,'yaxis') 
 
figure
subplot(2,1,1);
X=(double(EEG.data(elect,:,trialnum)));
[y,f,t,p] =SPECTROGRAM(X,window,Noverlap,F,1024,'yaxis') ;
 surf(t,f,10*log10(abs(p)),'EdgeColor','none');   
axis xy; axis tight; %colormap(jet);
view(0,90);
      xlabel('Time');
      ylabel('Frequency (Hz)');
subplot(2,1,2);
plot(EEG.data(73,:,trialnum));
hold on
plot(EEG.data(74,:,trialnum),'g');
legend('horizontal','vertical')
ylabel('gaze position')
sides=length(EEG.data(74,:,trialnum))-t(end)*1024;
xlim([sides/2 length(EEG.data(74,:,trialnum))-sides/2])