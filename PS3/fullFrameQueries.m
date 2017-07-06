function fullFrameQueries
    %establish paths
    close all;
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    %load kMeans from part 2
    fprintf('FQ: Loading .mat files...\n');
    load('kMeans1.mat');
    load('histograms.mat');
    imagenames = ['/friends_0000001080.jpeg';
                  '/friends_0000002070.jpeg';
                  '/friends_0000005317.jpeg'];
    
    fprintf('FQ: Fetching query images...\n');
    queryH = [];
    for i = 1:size(imagenames,1)
        ff = strcat(imagenames(i,:), '.mat');
        im = dir([siftdir ff]);
        fname = [siftdir '/' im.name];
        load(fname, 'imname', 'descriptors');
        imname = [framesdir imagenames(i,:)]; % add the full path
        %im= imread(imname);
        %imshow(im);
        [histo,~] = makeHistogram(descriptors, kMeans);
        queryH = cat(1,queryH,histo');
    end
    %queryH: 3*1500
    
    fprintf('FQ: Finding equivalent images...\n');
    list1 = [];
    list2 = [];
    list3 = [];
    names1 = [];
    names2 = [];
    names3 = [];
    
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
        
        if strcmp(imagenames(1,:), imname)
            continue;
        end
        if strcmp(imagenames(2,:), imname)
            continue;
        end
        if strcmp(imagenames(3,:), imname)
            continue;
        end
        
        % read in the associated image
        imname = [framesdir imname]; % add the full path
        
        %get histogram of each loaded image
        histo = histograms(i,:);
        
        %compare histogram to any of the thee query images
        score1 = scoreHistogram(queryH(1,:), histo);
        %if their score is above a certain threshold, put their name in a list
        if (score1 > 0.3)
            list1 = cat(1,list1,score1);
            names1 = cat(1, names1, imname);
        end
        score2 = scoreHistogram(queryH(2,:), histo);
        if (score2 > 0.3)
            list2 = cat(1,list2,score2);
            names2 = cat(1, names2, imname);
        end
        score3 = scoreHistogram(queryH(3,:), histo);
        if (score3 > 0.3)
            list3 = cat(1,list3,score3);
            names3 = cat(1, names3, imname);
        end
    end
    
    %sort through scores to get the top 4 names for each query
    win1 = sortTopImages(list1, names1);
    win2 = sortTopImages(list2, names2);
    win3 = sortTopImages(list3, names3);
    
    %display top 5 results for each query image
    fprintf('FQ: results for query: ');
    figure;
    subplot(3,3,1);
    imname = [framesdir imagenames(1,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    title('Query Image');
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
    figure;
    subplot(3,3,1);
    imname = [framesdir imagenames(2,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    title('Query Image');
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
    figure;
    subplot(3,3,1);
    imname = [framesdir imagenames(3,:)]; % add the full path
    disp(imname);
    im = imread(imname);
    imshow(im);
    title('Query Image');
    for i = 1:size(win3,1)
        n = i + 1;
        subplot(3,3,n);
        disp(win3(i,:));
        g = imread(win3(i,:));
        imshow(g);
        t = ['Match Rank ' int2str(i)];
        title(t);
    end
end
