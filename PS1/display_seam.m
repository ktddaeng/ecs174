function m = display_seam(im,seam,seamDirection)
    m = im;
    if strcmp(seamDirection, 'VERTICAL')
        for i = 1:size(im,1)
            m(i,seam(i),:) = [255,0,0];
        end
    elseif strcmp(seamDirection, 'HORIZONTAL')
        for j = 1:size(im,2)
           m(seam(j),j,:) = [255,0,0];     
        end
    else
        fprintf('Error: invalid seam direction \n');
    end
    imagesc(m);
end