function [freqbins,psds,phases]=getpowerspecwphase(signal,samplingrate)
%This fucntion takes a signal its sampling rate, and
%gives back frequency scaled bins, scaled amplitudes and phases.
%RA 8/2014
sr = samplingrate;
T = 1/sr;                               % Sample time
L = length(signal);                     % Length of signal
NFFT = 2^nextpow2(L); % for calculating n. 
Y = fft(signal,NFFT)/L;
freqbins = sr/2*linspace(0,1,NFFT/2+1);
psds=2*abs(Y(1:NFFT/2+1));
phases=angle(Y(1:NFFT/2+1));