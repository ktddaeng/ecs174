function seam_carving_reduce_width
    i = imread('inputSeamCarvingPrague.jpg');
    ii = doTheSeamWidth(i,100);
    imwrite(ii,'outputReduceWidthPrague.png');
    j = imread('inputSeamCarvingMall.jpg');
    jj = doTheSeamWidth(j,100);
    imwrite(jj,'ouputReduceWidthMall.png');
end

function im1 = doTheSeamWidth(im, num)
    im1 = im;
    e = energy_image(im);
    %[im1, e1] = reduce_width(im, e);
    for i = 1:num
        disp(sprintf('Iteration number %d',i));
        [im1,e] = reduce_width(im1,e);
    end
    
end