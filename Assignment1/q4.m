clear all;
close all;
pause_time = 3;
poly_circle = imread('basic.jpg');                  % for simple image with square and ellipse
figure; imshow(poly_circle); title("Normal Picture");
pause(pause_time);
nearest_neighbour_resize(poly_circle, [5,5])
pause(pause_time);
linear_resize(poly_circle, [5,5])
pause(pause_time);
nearest_neighbour_resize(poly_circle, [10,10])
pause(pause_time);
linear_resize(poly_circle, [10,10])
pause(pause_time);

black_white = imread('blackandwhite.jpg');          % for simple b&w image
figure; imshow(black_white);  title("Normal Picture");
pause(pause_time);
nearest_neighbour_resize(black_white, [5,5])
pause(pause_time);
linear_resize(black_white, [5,5])
pause(pause_time);
nearest_neighbour_resize(black_white, [10,10])
pause(pause_time);
linear_resize(black_white, [10,10])
pause(pause_time);

colored = imread('color.jpg');                  % for colored image
figure; imshow(colored); title("Normal Picture");
pause(pause_time)
nearest_neighbour_resize(colored, [5,5]);
pause(pause_time);
linear_resize(colored, [5,5]);
pause(pause_time);
nearest_neighbour_resize(colored, [10,10])
pause(pause_time);
linear_resize(colored, [10,10])
pause(pause_time);


function NN_Resizing = nearest_neighbour_resize(matrix_of_image, scale) 
    [horizontal,vertical,~] = size(matrix_of_image);                                     %getting the size of image provided
    newSize = scale .* [horizontal,vertical];                                        % setting the New Sizes
    rowInd = int64(min(round((1:newSize(1)) ./ scale(1)+1), horizontal));
    colInd = int64(min(round((1:newSize(2)) ./ scale(2)+1), vertical));
    newImage = matrix_of_image(rowInd,colInd,:);
    figure;
    imshow(newImage); title("NN Picture");
end

function Bilear_Resizing = linear_resize(matrix_of_image, scale)
    [horizontal, vertical, channel] = size(matrix_of_image);  
    newSize = scale .* [horizontal, vertical];
    scale_factor = [horizontal, vertical] ./ [newSize(1), newSize(2)];
    [factor_col, factor_row] = meshgrid(1 : newSize(2), 1 : newSize(1));
    factor_row = factor_row * scale_factor(1);
    factor_col = factor_col * scale_factor(2);
    row = floor(factor_row);
    col = floor(factor_col);
    row(row < 1) = 1;
    col(col < 1) = 1;
    row(row > horizontal - 1) = horizontal - 1;
    col(col > vertical - 1) = vertical - 1;
    row_step_variation = factor_row - row;
    col_step_variation = factor_col - col;
    at_origin = sub2ind([horizontal, vertical], row, col);
    end_xaxes = sub2ind([horizontal, vertical], row+1,col);
    end_yaxes = sub2ind([horizontal, vertical], row, col+1);
    end_allaxes = sub2ind([horizontal, vertical], row+1, col+1);
    out = zeros(newSize(1), newSize(2), channel);
    out = cast(out, class(matrix_of_image));
    for looper = 1 : channel
        original = double(matrix_of_image(:,:,looper));
        temp = original(at_origin).*(1 - row_step_variation).*(1 - col_step_variation) + ...
                       original(end_xaxes).*(row_step_variation).*(1 - col_step_variation) + ...
                       original(end_yaxes).*(1 - row_step_variation).*(col_step_variation) + ...
                       original(end_allaxes).*(row_step_variation).*(col_step_variation);
        out(:,:,looper) = cast(temp, class(matrix_of_image));
    end
    figure;
    imshow(out); title("BILINEAR Picture");
end
