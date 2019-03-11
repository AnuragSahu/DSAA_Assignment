clear all;
close all;
number_of_graphs = 3;

[audio_in,audio_freq_sampl]=audioread('./sa_re_ga_ma.wav');
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,1);
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in);                                            % default movmean
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,2);
plot(frequency_audio,abs(FFT_audio_in));
title('After only smoothing Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'movmedian',20);                             % movmedian
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,3);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(movmedian) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'gaussian',20);                              % gaussian
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,4);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(gaussian) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'lowess',20);                                % lowess
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,5);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(lowess) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'loess',20);                                 % loess
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,6);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(loess) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'rlowess',20);                               % rlowess
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,7);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(rlowess) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'rloess',20);                                % rloess
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,8);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(rloess) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audio_in = smoothdata(audio_in,'sgolay',20);                                % sgolay
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
subplot(number_of_graphs,3,9);
plot(frequency_audio,abs(FFT_audio_in));
title('After smoothing(sgolay) Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');