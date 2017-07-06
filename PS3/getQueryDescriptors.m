function getQueryDescriptors    
    imagenames = ['/friends_0000005744.jpeg'; %dress pattern
                  '/friends_0000002536.jpeg'; %blinds
                  '/friends_0000005520.jpeg'; %region: the painting
                  '/friends_0000006404.jpeg'];%failiure case: chair rungs

    close all;
    %establish working folders and directories    
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    queryH = [];
    %{
    for i = 1:size(imagenames,1)
        imname = [framesdir imagenames(i,:)];
        im = imread(imname);
        figure;
        imshow(im);
    end
    %}
    
    ff = strcat(imagenames(1,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');   
    %select region to get limited descriptors
    imname = [framesdir imagenames(1,:)];
    im1 = imread(imname);
    [oninds, bound] = selectRegionMod(im1, positions);
    %hold on;
    imshow(im1);
    hold on;
    h = fill(bound(:,1),bound(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    inds1 = oninds;
    bounds1 = bound;
    
    ff = strcat(imagenames(2,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');   
    %select region to get limited descriptors
    imname = [framesdir imagenames(2,:)];
    im1 = imread(imname);
    [oninds, bound] = selectRegionMod(im1, positions);
    %hold on;
    imshow(im1);
    hold on;
    h = fill(bound(:,1),bound(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    inds2 = oninds;
    bounds2 = bound;
    
    ff = strcat(imagenames(3,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');   
    %select region to get limited descriptors
    imname = [framesdir imagenames(3,:)];
    im1 = imread(imname);
    [oninds, bound] = selectRegionMod(im1, positions);
    %hold on;
    imshow(im1);
    hold on;
    h = fill(bound(:,1),bound(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    inds3 = oninds;
    bounds3 = bound;
    
    ff = strcat(imagenames(4,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');   
    %select region to get limited descriptors
    imname = [framesdir imagenames(4,:)];
    im1 = imread(imname);
    [oninds, bound] = selectRegionMod(im1, positions);
    %hold on;
    imshow(im1);
    hold on;
    h = fill(bound(:,1),bound(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    inds4 = oninds;
    bounds4 = bound;
    
    disp(size(inds1));
    disp(size(inds2));
    disp(size(inds3));
    disp(size(inds4));
    
    save('oninds.mat','inds1','inds2','inds3','inds4', 'bounds1', 'bounds2', 'bounds3', 'bounds4');
end