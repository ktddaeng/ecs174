function rawDescriptorMatches
    close all;
    %establish working folders and directories    
    addpath('./provided_code/');
    
    %load descriptors & images
    fname = 'twoFrameData.mat';
    load(fname, 'im1', 'im2', 'descriptors1', 'descriptors2', 'positions1', 'positions2', 'scales1', 'scales2', 'orients1', 'orients2');
    
    %use selectregion.m to get region of interest in im1
    [oninds, bound] = selectRegionMod(im1, positions1);
    disp(size(oninds));
    hold on;
    
    %display region of interest in im1
    imshow(im1);
    hold on;
    h = fill(bound(:,1),bound(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    
    %match descriptors in the region to descriptors in the second image
    %   based on Euclidean distance in SIFT space (use dist2.m)
    newInd = [];
    for i = 1:size(oninds,1)
        [index, score] = getNearestRawDescriptor(oninds(i), descriptors1, descriptors2);
        if (score < 0.5)    %0.4 threshold has better results but stricter
            %add index of desired 2nd descriptor to finalized list
            newInd = cat(1,newInd,index);
        end
    end
    disp(size(newInd));
    
    %display matched features of im2
    figure;
    imshow(im2);
    displaySIFTPatches(positions2(newInd,:), scales2(newInd), orients2(newInd), im2); 
end