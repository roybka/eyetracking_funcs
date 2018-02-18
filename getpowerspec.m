
%this fucntion takes a signal input and the sampling rate frequency, and
%outputs frequency scaled bins and scaled amplitudes.
%based on the FFT example in matlab.


function [freqbins,psds,phases]=getpowerspec(signal,samplingrate)
Fs = samplingrate;
T = 1/Fs;                               % Sample time
L = length(signal);                     % Length of signal
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(signal,L)/L; %normalize the FFT
freqbins = Fs/2*linspace(0,1,L/2+1); %finding the frequency axis
psds=2*abs(Y(1:L/2+1));
phases=angle(Y(1:L/2+1));