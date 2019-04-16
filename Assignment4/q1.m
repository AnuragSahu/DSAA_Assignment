close all;
clear all;

N = 8;
qm = [16	11	10	16 	24 	40 	51 	61;
      12	12	14	19 	26 	58 	60 	55;
      14	13	16	24 	40 	57 	69 	56;
      14	17	22	29 	51 	87 	80 	62;
      18	22	37	56 	68 	109	103	77;
      24	35	55	64 	81 	104	113	92;
      49	64	78	87 	103	121	120	101;
      72	92	95	98	112	100	103	99];
  
%% Question 1.1 

% part(a)
F = create_mat_dct(N)
disp("create_mat_dct OP : ");
disp(F);
disp("dctmtx() OP :");
disp(dctmtx(N));


plots = 3;
% part(b)
im = create_image(N,N);
disp("random Image : "),disp(im)
disp("Transform : ");
transform = myDCT(im,F);
disp(transform);


% part(c)
inverse_transpose = myIDCT(transform,F);
disp(inverse_transpose);

plots = 3;
% part(d)
c = 1;
imqDCT = myDCT_quantization(transform, qm, c);


% part(e)
imqIDCT = myDCT_dequantization(imqDCT, qm, c);
imqIDCT = myIDCT(imqIDCT,F);
disp("imqIDCT image"), disp(imqIDCT);

% part(f)
im1 = create_image(5,8);
im2 = create_image(2,19);
RSME_er = RSME(im1, im2);
disp("the Error Between the Images : ")
disp(RSME_er);

% part(g)
im1 = create_image(5,5);
en = entrpy(im1);
disp("entropy from my function : "),disp(en);
disp("entropy from inbuild function : "),disp(entropy(im1));

%% Question 1.2
lake_image = double(imread("LAKE.TIF"));
lake_image_1 = lake_image(420:420+7, 45:45+7);
lake_image_2 = lake_image(427:427+7, 298:298+7);
lake_image_3 = lake_image(30:30+7, 230:230+7);

im_dct_1 = myDCT(lake_image_1,F);disp(im_dct_1);
im_dct_2 = myDCT(lake_image_2,F);
im_dct_3 = myDCT(lake_image_3,F);
% Show image DCT
% Show quantised DCT
% Show reconstructed Image
c = 2;
im_dct1 = myDCT_quantization(im_dct_1,qm,c);disp(im_dct1);
im_dct2 = myDCT_quantization(im_dct_2,qm,c);
im_dct3 = myDCT_quantization(im_dct_3,qm,c);

figure;
subplot(6,1,1),imshow(mat2gray(lake_image_1)), title("lake img 1");
subplot(6,1,2),imshow(mat2gray(lake_image_2)), title("lake img 2");
subplot(6,1,3),imshow(mat2gray(lake_image_3)), title("lake img 3");

subplot(6,1,4),imshow(mat2gray(myIDCT(myDCT_dequantization(im_dct1,qm,c),F))), title("lake img 1 DCT qua");
subplot(6,1,5),imshow(mat2gray(myIDCT(myDCT_dequantization(im_dct2,qm,c),F))), title("lake img 2 DCT qua");
subplot(6,1,6),imshow(mat2gray(myIDCT(myDCT_dequantization(im_dct3,qm,c),F))), title("lake img 3 DCT qua");


%% Question 1.3

c = 10;  %% Change this for changing the Value of C in Q4

[DCT_quant,DCT_my] = DCT_whole_quant(lake_image,F,qm,c);
figure;subplot(2,1,1),imshow(mat2gray(DCT_quant)),title("DCT Transformed Image");
subplot(2,1,2),imshow(mat2gray(DCT_my)),title("Quantised DCT Transformed Image");

%% Question 1.4
DCT_dequant = DCT_whole_dequant(lake_image,F,qm,c);
figure,subplot(1,2,2),imshow(mat2gray(DCT_dequant)),title(sprintf("Constructed Image C = %d",c));
subplot(1,2,1),imshow(mat2gray(lake_image)),title("Original Image");
%% All the functions 

function [DCT_quant,DCT_my] = DCT_whole_quant(im,F,qm,c)
    [im_len, im_bre] = size(im);
    DCT_quant = zeros(im_len,im_bre);
    DCT_my = zeros(im_len,im_bre);
    for len = 1:8:im_len
        for bre = 1:8:im_bre
            DCT_quant (len:len+7,bre:bre+7) = myDCT(im(len:len+7,bre:bre+7),F);
            DCT_my (len:len+7,bre:bre+7) = myDCT_quantization(myDCT(im(len:len+7,bre:bre+7),F),qm,c);
        end
    end
end


function DCT_quant = DCT_whole_dequant(im,F,qm,c)
    [im_len, im_bre] = size(im);
    DCT_quant = zeros(im_len,im_bre);
    for len = 1:8:im_len
        for bre = 1:8:im_bre
            DCT_quant (len:len+7,bre:bre+7) = myIDCT(myDCT_dequantization(myDCT(im(len:len+7,bre:bre+7),F),qm,c),F);
        end
    end
end

function en = entrpy(im1)
    [im_len, im_bre] = size(im1);
    [count,binlocations] = imhist(im1);
    count(count==0)=[];
    count = count/(im_len*im_bre);
    en = -sum(count.*log2(count));
end

function RSME_er = RSME(im1,im2)
    % Get the Dimentions of the image
    [im1_len, im1_bre] = size(im1);
    [im2_len, im2_bre] = size(im2);
    
    difference_in_len = im1_len - im2_len;
    difference_in_bre = im1_bre - im2_bre;
    
    pad_im1_len = 0;
    pad_im2_len = 0;
    pad_im1_bre = 0;
    pad_im2_bre = 0;
    
    if(difference_in_len < 0)
        pad_im1_len = - difference_in_len;
    elseif(difference_in_len > 0)
        pad_im2_len = difference_in_len;
    end
    if(difference_in_bre < 0)
        pad_im1_bre = - difference_in_bre;
    elseif(difference_in_bre > 0)
        pad_im2_bre = difference_in_bre;
    end
    
    % zero padding the images
    im1 = padarray(im1,[pad_im1_len,pad_im1_bre],'post');
    im2 = padarray(im2,[pad_im2_len,pad_im2_bre],'post');
    [im_len, im_bre] = size(im1);
    err = im1 - im2;
    RSME_er = sqrt(sum(sum(err .* err))/im_len*im_bre);
    
end


function imqIDCT = myDCT_dequantization(imqDCT,qm,c)
    imqIDCT = round(imqDCT.*(c*qm));
end


function imqDCT = myDCT_quantization(imDCT,qm,c)
    imqDCT = round(imDCT.*(1./(c*qm)));
end

function inverse = myIDCT(im,F)
    inverse = round(transpose(F)*im*F);
end


function im = create_image(N,M)
    im = rand(N,M);
end

function transformed_im =  myDCT(im,F)
    transformed_im = F*im*transpose(F);
end

function F =  create_mat_dct(N)
    F = zeros(N);
    for v = 1:N
        for u = 1:N
            r = sqrt(2/N);
            if v==1
                r = sqrt(1/N);
            end
            F(v,u) =r*cos((pi * (2*(u-1)+1)*(v-1))/(2*N));
        end
    end
end
