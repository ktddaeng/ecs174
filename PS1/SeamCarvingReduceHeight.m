function SeamCarvingReduceHeight
    i = imread('inputSeamCarvingPrague.jpg');
    ii = doTheSeamHeight(i,50);
    imwrite(ii,'outputReduceHeightPrague.png');
    j = imread('inputSeamCarvingMall.jpg');
    jj = doTheSeamHeight(j,50);
    imwrite(jj,'ouputReduceHeightMall.png');
end

function im1 = doTheSeamHeight(im, num)
    im1 = im;
    e = energy_image(im);
    %[im1, e1] = reduce_width(im, e);
    for i = 1:num
        disp(sprintf('Iteration number %d',i));
        [im1,e] = reduce_height(im1,e);
    end
    
end