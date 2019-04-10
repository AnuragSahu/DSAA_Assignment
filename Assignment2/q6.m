

image = imread('cameraman.tif');
subplot(1,3,1);     imshow(image,[]); title('Original Image');
freq_domain = ((fft2(double(image))));
image_recon = abs(fft2(double(freq_domain)));
subplot(1,3,2); imshow(image_recon,[]); title('Reconstructed Image');
fully_recover = abs(fft2(flipud(fliplr(freq_domain))));
subplot(1,3,3); imshow(fully_recover,[]); title('Fully Recovered Image');