function []=averagetrialspect(EEG,trials,elect)
% this function plots an averaged spectrogram of gamma frequency power of a few eeg trials.

%allows choice of trial number and electrode.
%works conveniently on raw EEGLAB data.
% 
%input:EEG-- 3d eeglab array (electrodes by datapoints by trials) , along with 
%               trials - vector of wanted trials
%               elect  - selected electrode
F=[20:1:90]; %frequencies in play
window=120; %window length
Noverlap=115; %num of overlapping samples
% X=(double(EEG.data(48,:,8)));
% %S = SPECTROGRAM(X,WINDOW,NOVERLAP,NFFT) 
%  [S,F,T,P] =SPECTROGRAM(X,[],[],F,1024,'yaxis') 
% trials=8,
figure

for i=1:length(trials)
    
X=(double(EEG.data(elect,:,trials(i))));
[y,f,t,p(i,:,:)] =spectrogram(X,window,Noverlap,F,1024,'yaxis') ;
end
pp=squeeze(mean(p,1));
 surf(t,f,10*log10(abs(pp)),'EdgeColor','none');   
axis xy; axis tight; %colormap(jet);
view(0,90);
      xlabel('Time');
      ylabel('Frequency (Hz)');