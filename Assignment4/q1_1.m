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
      72	92	95	98	112	100	103	99]
  
%% Question 1.1 

% part(a)
F = create_mat_dct(N);
disp("create_mat_dct OP : ");
disp(F);
disp("dctmtx() OP :");
disp(dctmtx(N))

% part(b)
im = create_image(N,N);
disp("random Image : "),disp(im)
figure,imshow(im),title("Random Image");
disp("Transform : ");
transform = myDCT(im,F);
disp(transform);
figure,imshow(transform),title("DCT Transform");

% part(c)
inverse_transpose = myIDCT(transform,F);
figure,imshow(inverse_transpose),title("IDCT Transform");
disp(inverse_transpose);

% part(d)
c = 3;
imqDCT = myDCT_quantization(transform, qm, c);
disp("imqDCT image"), disp(imqDCT)
figure, imshow(imqDCT), title("Quantised Image");

% part(e)
imqIDCT = myDCT_dequantization(imqDCT, qm, c);
disp("imqIDCT image"), disp(imqIDCT)
figure, imshow(imqIDCT), title("de_Quantised Image");

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




%% All the functions 

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
    imqIDCT = imqDCT.*(c*qm);
end


function imqDCT = myDCT_quantization(imDCT,qm,c)
    imqDCT = imDCT./(c*qm);
end

function inverse = myIDCT(im,F)
    inverse = transpose(F)*im*F;
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
