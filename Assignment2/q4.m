clear all;
close all;

[audio,Fs] = audioread('signal_4.wav');
sound(audio);  pause(40);
filterDesign= designfilt('lowpassfir','PassbandFrequency',0.15,...
                            'StopbandFrequency',0.3, ...
                            'PassbandRipple',1, ...
                            'StopbandAttenuation',160, ...
                            'DesignMethod','kaiserwin');

f_op = filtfilt(filterDesign,audio);
f_op = f_op .* 2;
sound(f_op);
pspectrum(f_op(1:length(f_op)),Fs,'spectrogram');
