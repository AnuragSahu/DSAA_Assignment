clc;
clear all;
close all;
%% Part 1 of q7
[audio] = double(audioread('chirp.wav'));
window_size = 200;
stride  = 20;
subplot(1,2,1); result = spectrogram(audio,window_size,stride);
title("My Function");
subplot(1,2,2);  spectrogram(audio,window_size,stride);
title("Inbuild Function");




%% Part 2 of q7

clear all;
figure;
[audio,Fs] = audioread('message.wav');
pspectrum(audio,Fs,'spectrogram');

%% Part 3 of q7

clear all;
figure;
roll_number = 2018121004;
dial_tone_op = dial_tone(roll_number);
%sound(dial_tone_op,44100*1.5);
pspectrum(dial_tone_op,44100,'spectrogram','Leakage',1,'OverlapPercent',0,'MinThreshold',-10,'FrequencyLimits',[650,1500]);

function dial_tone_op = dial_tone(roll_number)
    Fs = 44100;
    all_digits = dec2base(roll_number,10)-'0';
    pause = zeros(0.1*Fs,1);
    dial_tone_op = zeros(0.1*Fs,1);
    for n = 1:length(all_digits)
        [aud,~] = audioread(strcat('./q3/',int2str(all_digits(n)),'.ogg'));
        dial_tone_op = [dial_tone_op;aud;pause];
    end
end

function result = spectrogram(audio,window_size,stride)
    number_of_fft = ceil((size(audio,1)-window_size)/stride);
    final_spectrogram = ones([500 number_of_fft]);
    for i = [0:number_of_fft-1]
        fft_done = fftshift(fft(double(audio(i*stride+1 : i*stride+window_size))));
        final_spectrogram(1:size(fft_done)/2,i+1) = abs(fft_done(1:size(fft_done)/2));
    end
    result = mat2gray(log(1 + final_spectrogram));
    imshow(result);
end