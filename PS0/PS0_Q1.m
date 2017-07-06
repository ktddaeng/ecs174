function PS0_Q1
    clear;
    close all;
    mfile = matfile('PS0_A.mat');

    figure(1);
    M = mfile.A;
    M1 = sort(M(:), 'descend');
    X1 = 1:length(M1);
    plot(X1, M1);

    figure(2);
    nbins = 10;
    M2 = histogram(M1, nbins);

    figure(3);
    Z = M((length(M)/2+1):length(M), 1:length(M)/2);
    imagesc(Z);

    figure(4);
    W = M-mean(M1);
    imagesc(W);

    figure(5);
    P = zeros(50,50,3);
    t = mean(M(:));
    red = P(:,:,1);
    green = P(:,:,2);
    blue = P(:,:,3);
    ind = (M > t);
    red(ind(:,:,1)) = 255;
    green(:) = 0;
    blue(:) = 0;
    Y = cat(3,red,green,blue);
    imshow(Y);
end