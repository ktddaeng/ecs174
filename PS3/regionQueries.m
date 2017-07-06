function regionQueries
    close all;
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    %list of query images, 3 success, 1 fail
    fprintf('FQ: Loading .mat files...\n');
    load('kMeans1.mat');
    load('histograms.mat');
    load('oninds.mat');
    imagenames = ['/friends_0000005744.jpeg'; %dress pattern
                  '/friends_0000002536.jpeg'; %blinds
                  '/friends_0000005520.jpeg'; %region: the painting
                  '/friends_0000006404.jpeg']; %failiure case: chair rung
              
    fig1 = figure;  %subplot , 4 at the top, 5 at the bottom
    fig2 = figure;
    fig3 = figure;    
    fig4 = figure;
    
    %for each query region
    fprintf('FQ: Fetching query regions...\n');
    queryH = [];
    
    %save('oninds.mat','inds1','inds2','inds3','inds4');
    ff = strcat(imagenames(1,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'imname', 'descriptors');
    d = descriptors(inds1,:);
    [histo,~] = makeHistogram(d, kMeans);
    queryH = cat(1,queryH,histo');    
    
    ff = strcat(imagenames(2,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'imname', 'descriptors');
    d = descriptors(inds2,:);
    [histo,~] = makeHistogram(d, kMeans);
    queryH = cat(1,queryH,histo');
    
    ff = strcat(imagenames(3,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'imname', 'descriptors');
    d = descriptors(inds3,:);
    [histo,~] = makeHistogram(d, kMeans);
    queryH = cat(1,queryH,histo');
    
    ff = strcat(imagenames(4,:), '.mat');
    im = dir([siftdir ff]);
    fname = [siftdir '/' im.name];
    load(fname, 'imname', 'descriptors');
    d = descriptors(inds4,:);
    [histo,~] = makeHistogram(d, kMeans);
    queryH = cat(1,queryH,histo');
        
    fprintf('FQ: Finding equivalent images...\n');
    list1 = [];
    list2 = [];
    list3 = [];
    list4 = [];
    names1 = [];
    names2 = [];
    names3 = [];
    names4 = [];
    fnames = dir([siftdir '/*.mat']);
    
    for i=1:length(fnames) 
        %load all images  
        
        fprintf('FQ: reading frame %d of %d\n', i, length(fnames));
        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors');
        if size(descriptors,1) == 0
            continue;
        end

        % read in the associated image
        if strcmp(imagenames(1,:), imname)
            continue;
        end
        if strcmp(imagenames(2,:), imname)
            continue;
        end
        if strcmp(imagenames(3,:), imname)
            continue;
        end
        if strcmp(imagenames(4,:), imname)
            continue;
        end
        
        imname = [framesdir imname]; % add the full path
        
        %get histogram of each loaded image
        histo = histograms(i,:);
        
        %compare histogram to any of the thee query images
        score1 = scoreHistogram(queryH(1,:), histo);
        %if their score is above a certain threshold, put their name in a list
        if (score1 > 0)
            list1 = cat(1,list1,score1);
            names1 = cat(1, names1, imname);
        end
        score2 = scoreHistogram(queryH(2,:), histo);
        if (score2 > 0)
            list2 = cat(1,list2,score2);
            names2 = cat(1, names2, imname);
        end
        score3 = scoreHistogram(queryH(3,:), histo);
        if (score3 > 0.)
            list3 = cat(1,list3,score3);
            names3 = cat(1, names3, imname);
        end        
        score4 = scoreHistogram(queryH(4,:), histo);
        if (score4 > 0)
            list4 = cat(1,list4,score4);
            names4 = cat(1, names4, imname);
        end
    end
    disp(size(list2));
    
    %sort scores
    win1 = sortTopImages(list1, names1);
    win2 = sortTopImages(list2, names2);
    win3 = sortTopImages(list3, names3);
    win4 = sortTopImages(list4, names4);
    
    %display images
    fprintf('FQ: results for query: ');
    figure(fig1);
    subplot(3,3,1);
    imname = [framesdir imagenames(1,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds1(:,1),bounds1(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Query Region');
    for i = 1:size(win1,1)
        n = i + 1;
        subplot(3,3,n);
        disp(win1(i,:));
        g = imread(win1(i,:));
        imshow(g);
        t = ['Match Rank ' int2str(i)];
        title(t);
    end
    
    fprintf('FQ: results for query: ');
    figure(fig2);
    subplot(3,3,1);
    imname = [framesdir imagenames(2,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds2(:,1),bounds2(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Query Region');
    for i = 1:size(win2,1)
        n = i + 1;
        subplot(3,3,n);
        disp(win2(i,:));
        g = imread(win2(i,:));
        imshow(g);
        t = ['Match Rank ' int2str(i)];
        title(t);
    end
    
    fprintf('FQ: results for query: ');
    figure(fig3);
    subplot(3,3,1);
    imname = [framesdir imagenames(3,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds3(:,1),bounds3(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Query Region');
    for i = 1:size(win3,1)
        n = i + 1;
        subplot(3,3,n);
        disp(win3(i,:));
        g = imread(win3(i,:));
        imshow(g);
        t = ['Match Rank ' int2str(i)];
        title(t);
    end
    
    fprintf('FQ: results for query: ');
    figure(fig4);
    subplot(3,3,1);
    imname = [framesdir imagenames(4,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds4(:,1),bounds4(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Query Region');
    for i = 1:size(win4,1)
        n = i + 1;
        subplot(3,3,n);
        disp(win4(i,:));
        g = imread(win4(i,:));
        imshow(g);
        t = ['Match Rank ' int2str(i)];
        title(t);
    end
end