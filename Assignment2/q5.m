clc;
close all;
clear all;


dft_time = [ 0 0 0 ];
fft_time = [ 0 0 0 ];

image = double(imread("cameraman.tif"));
tic;
fft_done = DFT2_func(image);
dft_time(1) = toc;

image = double(imread("lena.bmp"));
tic;
fft_done = DFT2_func(image);
dft_time(2) = toc;


image = double(imresize(imread("inp1.png"),[1024,1024]));
tic;
fft_done = DFT2_func(image);
dft_time(3) = toc;


image = double(imread("cameraman.tif"));
tic;
fft_done = FFT2_func(image);
fft_time(1) = toc;



image = double(imread("lena.bmp"))
tic;
fft_done = FFT2_func(image);
fft_time(2) = toc;


image = double(imresize(imread("inp1.png"),[1024,1024]));
tic;
fft_done = FFT2_func(image);
fft_time(3)= toc;


figure;
hold on;
plot(fft_time);
plot(dft_time);

function result = DFT2_func(image)
	[r_image, c_image] = size(image);
	w_values_r = zeros(r_image);
    w_values_c = zeros(c_image);
	
	for k = 1:r_image
	    for l = 1:r_image
	        w_values_r(k,l) = exp(((-2i)*pi*(k-1)*(l-1))/r_image);
	    end
    end
    for k = 1:c_image
	    for l = 1:c_image
	        w_values_c(k,l) = exp(((-2i)*pi*(k-1)*(l-1))/c_image);
	    end
    end
    result = w_values_r * image * w_values_c;
end

function result = FFT2_func(image)
    [R,C]=size(image);
    
    for rows=0:R-1
        row=image(rows+1,:);
        result(rows+1,:) = FFT_func(row);
    end
    
    for cols=0:C-1 
        col(1,:)=result(:,cols+1);
        result(:,cols+1) = FFT_func(col);
    end
end

function y = FFT_func(x)
    n = length(x);
    if n == 1
        y = x;
    else
        if(nextpow2(n)-n > 0)
            x = padarray(x,nextpow2(n)-n);
        end
        m = n/2;
        y_even = FFT_func(x(1:2:(n-1)));
        y_odd = FFT_func(x(2:2:n));
        d = exp(-2 * pi * i / n) .^ (0:m-1);
        z = d .* y_odd;
        y = [ y_even + z , y_odd - z ];
    end
end