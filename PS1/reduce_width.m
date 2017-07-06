function [reducedColorImage, reducedEnergyImage] = reduce_width(im, energyImage)
    reducedColorImage = uint8(zeros(size(im,1), size(im,2)-1, 3));
    reducedEnergyImage = zeros(size(im,1), size(im,2)-1);
    pv = cumulative_energy_map(energyImage, 'VERTICAL');
    sv = find_optimal_vertical_seam(pv);
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