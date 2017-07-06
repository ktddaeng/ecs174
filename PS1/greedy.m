function greedy
    close all;
    im = imread('jellyfish.jpeg');
    doGreedy(im, 'VERTICAL', 100);
    im = imread('drink.jpeg');
    doGreedy(im, 'HORIZONTAL', 100);
end
function doGreedy(im, seamDirection, num)
    figure;
    e = energy_image(im);
    im1 = im;
    im2 = im;
    e2 = e;
    subplot(1,3,1);
    imshow(im);
    axis image;
    title('Original');
    if strcmp(seamDirection, 'VERTICAL')
        for i = 1:num
            disp(sprintf('Iteration number %d',i));
            [im1, e] = reduce_Gwidth(im1, e);
            [im2, e2] = reduce_width(im2, e2);
        end
    elseif strcmp(seamDirection, 'HORIZONTAL')
        for i = 1:num
            disp(sprintf('Iteration number %d',i));
            [im1, e] = reduce_Gheight(im1, e); 
            [im2, e2] = reduce_height(im2, e2);
        end
    else
        fprintf('Error: invalid seam direction \n');
    end
    subplot(1,3,2);
    imshow(im1);
    axis image;
    title('Greedy');
    subplot(1,3,3);
    imshow(im2);
    axis image;
    title('Dynamic');
end

function [reducedColorImage, reducedEnergyImage] = reduce_Gheight(im, energyImage)
    reducedColorImage = uint8(zeros(size(im,1)-1, size(im,2), 3));
    reducedEnergyImage = zeros(size(im,1)-1, size(im,2));
    sv = find_optimal_horizontal_seam(energyImage);
    red = im(:,:,1);
    green = im(:,:,2);
    blue = im(:,:,3);   
    for j = 1:size(im,2)
        red1 = red(:,j);
        green1 = green(:,j);
        blue1 = blue(:,j);
        red1(sv(j)) = [];       
        green1(sv(j)) = [];       
        blue1(sv(j)) = [];
        v = cat(3, red1, green1, blue1);
        reducedColorImage(:,j,:) = v;
        v = energyImage(:,j);
        v(sv(j)) = [];
        reducedEnergyImage(:,j) = v;
    end
end

function [reducedColorImage, reducedEnergyImage] = reduce_Gwidth(im, energyImage)
    reducedColorImage = uint8(zeros(size(im,1), size(im,2)-1, 3));
    reducedEnergyImage = zeros(size(im,1), size(im,2)-1);
    sv = find_optimal_vertical_seam(energyImage);
    red = im(:,:,1);
    green = im(:,:,2);
    blue = im(:,:,3);   
    for i = 1:size(im,1)
        red1 = red(i,:);
        green1 = green(i,:);
        blue1 = blue(i,:);
        red1(sv(i)) = [];       
        green1(sv(i)) = [];       
        blue1(sv(i)) = [];
        v = cat(3, red1, green1, blue1);
        reducedColorImage(i,:,:) = v;
        v = energyImage(i,:);
        v(sv(i)) = [];
        reducedEnergyImage(i,:) = v;
    end
end