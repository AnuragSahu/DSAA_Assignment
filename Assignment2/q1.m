clc;
close all;
clear all;

%% This is for Question 1 part 1
rows = 5;
cols = 4;

image = rgb2gray(imread('testimage.jpg'));
subplot(rows,cols,2);
imshow(image);
title('Original Image');

kernal_size = 64;
sigma = 0.1;
filter = gauss_filter(kernal_size,sigma);
subplot(rows,cols,5);
imshow(filter);
title("filter kernel = 64, sigma = 0.1");

blured_img = xcorr2(image,filter);
subplot(rows,cols,6);
imshow(blured_img);
title("Image filtered by filter I made");

subplot(rows,cols,7);
f_filter = fspecial('gaussian',kernal_size,sigma);
imshow(f_filter);
title("Filter of fspecial");

subplot(rows,cols,8);
imshow(xcorr2(image,f_filter));
title("Image filtered by fspecial filter");

kernal_size = 120;
sigma = 1;
filter = gauss_filter(kernal_size,sigma);
subplot(rows,cols,9);
imshow(filter);
title("filter kernel = 120, sigma = 1");

blured_img = xcorr2(image,filter);
subplot(rows,cols,10);
imshow(blured_img);
title("Image filtered by filter I made");

subplot(rows,cols,11);
f_filter = fspecial('gaussian',kernal_size,sigma);
imshow(f_filter);
title("Filter of fspecial");

subplot(rows,cols,12);
imshow(xcorr2(image,f_filter));
title("Image filtered by fspecial filter");

kernal_size = 120;
sigma = 10;
filter = gauss_filter(kernal_size,sigma);
subplot(rows,cols,13);
imshow(filter);
title("filter kernel = 120, sigma = 10");

blured_img = xcorr2(image,filter);
subplot(rows,cols,14);
imshow(blured_img);
title("Image filtered by filter I made");

subplot(rows,cols,15);
f_filter = fspecial('gaussian',kernal_size,sigma);
imshow(f_filter);
title("Filter of fspecial");

subplot(rows,cols,16);
imshow(xcorr2(image,f_filter));
title("Image filtered by fspecial filter");

kernal_size = 64;
sigma = 10;
filter = gauss_filter(kernal_size,sigma);
subplot(rows,cols,17);
imshow(filter);
title("filter kernel = 120, sigma = 10");

blured_img = xcorr2(image,filter);
subplot(rows,cols,18);
imshow(blured_img);
title("Image filtered by filter I made");

subplot(rows,cols,19);
f_filter = fspecial('gaussian',kernal_size,sigma);
imshow(f_filter);
title("Filter of fspecial");

subplot(rows,cols,20);
imshow(xcorr2(image,f_filter));
title("Image filtered by fspecial filter");

%% This is for Question 1 part 2
clear all;figure;
image = (imread('test_image_with_saltandpepeper_noise.png'));
subplot(2,1,1);
imshow(image);
title("Image with salt and pepper noise");
kernel_size = 3;    % Ideal Value is 3, also try 2, 4, 6
with_averaging_mean = median_filter(image, kernel_size);
subplot(2,1,2);
imshow(with_averaging_mean);
title("median Filter Applied");

%% This is for Question 1 part 3
clear all;figure;
image = imread("cameraman.tif");
%imshow(image);
kernel_size = 3;
sigma = 0.1;
g_filter = gauss_filter(kernel_size, sigma);
g_filtered = imfilter(image,g_filter);
N = 3;
median_filtered = median_filter(g_filtered,N);
imshow(median_filtered); title("Both Filters Applied");

%% This is for Question 1 part 4 
clear all;figure;
image = (imread('test_image_with_saltandpepeper_noise.png'));
subplot(2,1,1);
imshow(image);
title("Image with salt and pepper noise");
kernel_size = 3;    % Ideal Value is 3, also try 2, 4, 6
with_averaging_mean = median_filter(image, kernel_size);
subplot(2,1,2);
imshow(with_averaging_mean);
title("Noise removal of in1");

%% This is for Question 1 part 5
clear all;
image = imread("inp2.png");
subplot(2,2,1), imshow(image), title("Original Image");
freq_abs = abs((fft2(double(image))));
s=log(1+fftshift(freq_abs));
freq_angle = angle((fft2(double(image))));
subplot(2,2,2);   imshow(s,[]),  title("Fourier Transform of image");
fft_img = fftshift((fft2(double(image))));
diff = 10;

for j = 120-diff:120+diff  
    for n = 100-diff:100+diff
        fft_img(n,j) = 0;
        s(n,j) = 0;
    end
    for n = 220-diff:220+diff
        fft_img(n,j) = 0; 
        s(n,j) = 0;
    end
    for n = 280-diff:280+diff
        fft_img(n,j) = 0;
        s(n,j) = 0;
        
    end
    for n = 300-diff:300+diff
        fft_img(n,j) = 0;
        s(n,j) = 0;
        
    end
    for n = 17-diff:17+diff
        fft_img(n,j) = 0; 
        s(n,j) = 0;
    end
    for n = 42-diff:42+diff
        fft_img(n,j) = 0; 
        s(n,j) = 0;
    end
end


final_image = real(ifft2(ifftshift(fft_img)));
subplot(2,2,3); imshow(final_image,[]), title("Cleaned Image");
subplot(2,2,4), imshow(s,[]),  title("Filter applied");
figure, imshow(final_image,[]);


%% gauss_filter implementaiton
function ret = gauss_filter(N, sigma)
    ret = single(zeros(N));
    for row = 1 : N
        for col = 1 : N 
            x = row - N/2;
            y = col - N/2;
            ret(row, col) = (1/2*pi*sigma*sigma)*exp(-(x*x + y*y)/2*sigma*sigma);
        end
    end
    ret = mat2gray(ret);
end

%% Median Filter implementation

function mean_image = median_filter(I, N)
    set = im2col(I,[N N]);
    replace_with = (median(set));
    mean_image = col2im(replace_with, [N N],size(I));
end
   
   
