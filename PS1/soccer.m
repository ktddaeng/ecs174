function soccer
    clear;
    close all;
    M = imread('soccer.jpeg');
    
    subplot(3,4,[1,4]);
    imshow(M);
    axis image;
    title('Original Input');
    xlabel(sprintf('Dimensions: %d x %d', size(M,1), size(M,2)));
        
    E = energy_image(M);
    [M1, E1] = doTheSeamH(M, E, 50);
    [M2, E2] = doTheSeamH(M1, E1, 10);
    [M3, E3] = doTheSeamH(M2, E2, 50);
    [M4, E4] = doTheSeamH(M3, E3, 10);
    
    subplot(3, 4, 5);
    imshow(M1);
    axis image;
    title('50 seams');
    
    subplot(3, 4, 6);
    imshow(M2);
    axis image;
    title('60 seams');
    
    subplot(3, 4, 7);
    imshow(M3);
    axis image;
    title('110 seams');
    
    subplot(3, 4, 8);
    imshow(M4);
    axis image;
    title('120 seams');
    
    subplot(3,4,[9 10]);
    imshow(M4);
    axis image;
    title('Seam Carving');  
    xlabel(sprintf('Dimensions: %d x %d', size(M4,1), size(M4,2)));  
    
    subplot(3,4,[11 12]);
    M5 = imresize(M, [size(M4,1) size(M4,2)]);
    imshow(M5);
    axis image;
    title('imresize');    
    xlabel(sprintf('Dimensions: %d x %d', size(M5,1), size(M5,2))); 
end

function [im1, e1] = doTheSeamH(im, e, num)
    im1 = im;
    %[im1, e1] = reduce_width(im, e);
    for i = 1:num
        disp(sprintf('Iteration number %d',i));
        [im1,e] = reduce_height(im1,e);
        e1 = e;
    end
    
end

function [im1, e1] = doTheSeamW(im, e, num)
    im1 = im;
    %[im1, e1] = reduce_width(im, e);
    for i = 1:num
        disp(sprintf('Iteration number %d',i));
        [im1,e] = reduce_width(im1,e);
        e1 = e;
    end
    
end