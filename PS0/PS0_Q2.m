function PS0_Q2
    clear;
    close all;
    M = imread('PWAA_episode1.png');

    subplot(3,2,1);
    M1 = makeGray(M);
    imshow(M1);
    title('a. Grayscale');

    subplot(3,2,2);
    M2 = makeNegative(M1);
    imshow(M2);
    title('b. Negative Image');

    subplot(3,2,3);
    M3 = makeMirror(M);
    imshow(M3);
    title('c. Mirrored Image');

    subplot(3,2,4);
    M4 = makeBlueGreen(M);
    imshow(M4);
    title('d. Blue-Green Swap');

    subplot(3,2,5);
    M5 = makeAvgMirror(M, M3);
    imshow(M5);
    title('e. Averaged with Mirror');

    subplot(3,2,6);
    M6 = makeClip(M1);
    imshow(M6);
    title('f. Clipped Value');
end
    
function X1 = makeGray(X)
    X1 = rgb2gray(X);
end

function X2 = makeNegative(X)
    X2 = imcomplement(X);
end

function X3 = makeMirror(X)
    X3 = flipud(X);
end

function X4 = makeBlueGreen(X)
    red = X(:,:,1);
    green = X(:,:,2);
    blue = X(:,:,3);
    temp = green;
    green(:) = blue(:);
    blue(:) = temp(:);
    X4 = cat(3,red,green,blue);
end

function X5 = makeAvgMirror(X, X2)
    G = double(X);
    G2 = double(X2);
    X5 = uint8((G+G2)/2);
end

function X6 = makeClip(X)
    r = uint8(-1 + (255+1)*rand(1));
    X6 = X + r;
    X6(X6 > 255)= 255;
    whos;
end