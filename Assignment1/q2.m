 clear all;
 close all;
 
% Part 1 of Q2
pause_time = 10;
 file = 'forQ2.wav';
 [audio_in, frequency] = audioread(file);                                   % Reading the audio file
 sound(audio_in);                                                         % Listen to the output of audio file
 pause(60);
 disp('Now recording your voice');

 recordObject = audiorecorder;
 time = 5;                                                                  % the time duration for recording
 disp('Listening');
 recordblocking(recordObject, time);
 disp('Done reocrding, Playing your recorded voice.');
 play(recordObject);
 y = getaudiodata(recordObject);
 pause(pause_time);

% Part 2 of Q2
 Foriginal = 44.1e3;
 Fchange1 = 24e3;
 Fchange2 = 16e3;
 Fchange3 = 8e3;
 Fchange4 = 4e3;
 
 [p1,q1] = rat(Fchange1/Foriginal);
 ynew1 = resample(y,p1,q1);
 disp('Playing the subsampled signal of 24kHz');
 sound(ynew1);
 disp('Done for 24KHz');
 pause(pause_time/2);
 
 [p2,q2] = rat(Fchange2/Foriginal);
 ynew2 = resample(y,p2,q2);
 disp('Playing the subsampled signal of 16 kHz');
 sound(ynew2);
 disp('Done with 16Khz');
 pause(pause_time/4);
 
 [p3, q3] = rat(Fchange3/Foriginal);
 ynew3 = resample(y,p3,q3);
 disp('Playing the subsampled signal of 8kHz');
 sound(ynew3);
 disp('Done with the 8kHz');
 pause(pause_time/8);
 
 [p4,q4] = rat(Fchange4/Foriginal);
 ynew4 = resample(y,p4,q4);
 disp('Playing the subsampled signal of 4kHz');
 sound(ynew4);
 disp('Done with the 4kHz');
 pause(pause_time/8);

 % Part 3 of Q2
 [h1, freq1] = audioread('S1R1_sweep4000.wav');
 output1 = conv(y,h1);
 disp('playing convolution with first impulse response');
 sound(output1);
 pause(pause_time);

 [h2, freq2] = audioread('S2R1sbroad.wav');
 output2 = conv(y,h2);
 disp('playing convolution with secound impulse response');
 sound(output2);
 pause(pause_time);

 [h2, freq2] = audioread('Xx00y01.wav');
 output2 = conv(y,h2);
 disp('playing convolution with third impulse response');
 sound(output2);
 pause(pause_time*2);
 
 clear all;
 close all;
