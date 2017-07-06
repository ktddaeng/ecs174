function [reducedColorImage, reducedEnergyImage] = reduce_height(im, energyImage)
    reducedColorImage = uint8(zeros(size(im,1)-1, size(im,2), 3));
    reducedEnergyImage = zeros(size(im,1)-1, size(im,2));
    pv = cumulative_energy_map(energyImage, 'HORIZONTAL');
    sv = find_optimal_horizontal_seam(pv);
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