close all;
clear all;
clc
[audio_0,fs_0] = audioread('tone.wav');
pspectrum(audio_0,fs_0,'spectrogram','Leakage',1,'OverlapPercent',0,'MinThreshold',-10,'FrequencyLimits',[650,1500]);

%% answer = 20161103