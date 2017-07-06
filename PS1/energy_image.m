function energyImage = energy_image(im)
    %close all;
    x =  rgb2gray(im);
    My = fspecial('sobel');
    Mx = -My';
    Ox = imfilter(double(x), Mx);
    Oy = imfilter(double(x), My);
    %{
    figure;
    imagesc(Ox);
    colormap gray;
    figure;
    imagesc(Oy);
    colormap gray;
    %}
    energyImage = sqrt(Ox.^2 + Oy.^2);
    %{
    figure;
    imagesc(energyImage);
    colormap gray;
    %}
end

%a = imread('C:\Users\Kim\Documents\001100110011\DAVIS\2016_17_Junior\ECS 174\pexels-photo-380789.jpeg');
