clear all;
close all;

single_face = im2double(rgb2gray(imread('F1.jpg')));                           % Reading the F1 Image and converting it into a handleable matrix
multiple_faces = im2double(rgb2gray(imread('Faces.jpg')));                     % Reading the Faces Image and converting it into a handleable matrix
[rows, cols] = size(multiple_faces);                                           % Getting the Size of Faces Image
res = zeros(rows + size(single_face,1) -1, cols + size(single_face,2) - 1);    % size of normalize convulation matrix
res(size(single_face,1):size(res,1),size(single_face,2):size(res,2)) = multiple_faces(:,:); % Copying the faces matrix in the result matrix
WhiteFilter = ones(rows,cols);                                                         % creating a matrix with size of multiple_faces filled with ones 
for i=1:rows
    for j=1:cols
        WhiteFilter(i,j) = 0;
        var = 0;
        for k=1:size(single_face,1)
            for l=1:size(single_face,2)
                WhiteFilter(i,j) = WhiteFilter(i,j) + (single_face(k,l) * res(i+k-1,j+l-1));   % computing product of overlapped elements
                var = var + (res(i+k-1,j+l-1))^2;                                              % calculating the sum of squares of overlapped elements
            end
        end
        WhiteFilter(i,j) = WhiteFilter(i,j)/sqrt(var);
    end
end
[y_val, x_val] = find(WhiteFilter==max(WhiteFilter(:)));                   % Finding the peak values which matched the face matrix with faces matrix
yoffSet = y_val-size(single_face,1);                                       % Setting the sizes
xoffSet = x_val-size(single_face,2);
axes_set  = axes;
imshow(multiple_faces,'Parent', axes_set);                                 % showing the Original Image
imrect(axes_set, [xoffSet+1, yoffSet+1, size(single_face,2), size(single_face,1)]);  % Showing the rectangle on top of faces Image