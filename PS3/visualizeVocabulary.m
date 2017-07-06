function visualizeVocabulary
     %establish paths
     close all;
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    % Get a list of all the .mat files in that directory.
    % There is one .mat file per image.
    fnames = dir([siftdir '/*.mat']);

    %buildvocab and put into some variable to dump into k-means
    [vocabDesc, vocabPos, vocabSca, vocabOri, vocabMember, vocabMeans, vocabFile] = buildVocab;
    count = zeros(size(vocabMeans,2),1);
    
    fprintf('VV: counting occurrences...\n');
    for i=1:length(vocabMember)
        term = vocabMember(i);
        count(term) = count(term)+1;
    end
    
    [M1,I1] = max(count);
    M2 = 0;
    I2 = 0;
    if (length(I1) >= 2)
        I2 = I1(2);
        M2 = M1(2);
    end
    if (length(I1) < 2)
        [M2,I2] = max(count(count~=M1));
    end    
    
    if (M1 < 25 || M2 < 25)
        error('Student-made error. buildVocab.m could not find 25 matching patches for a word. Please run again.');
    end
    
    fprintf('VV: getting 25 patches...\n');
    list1 = find(vocabMember==I1);
    list11 = [];
    list2 = find(vocabMember==I2);
    list22 = [];
    
    word1 = vocabMeans(:,I1)';
    word2 = vocabMeans(:,I2)';
    
    for i = 1:length(list1)
        distances = dist2(word1, vocabDesc(list1(i),:));
        d = distances(1);
        v = [d list1(i)];
        list11 = cat(1,list11, v);
    end
    for i = 1:length(list2)
        distances = dist2(word2, vocabDesc(list2(i),:));
        d = distances(1);
        v = [d list2(i)];
        list22 = cat(1,list22, v);
    end
    list111 = sort(list11);
    list222 = sort(list22);
    
    %plot patches
    figure;
    for i = 1:25
        ind = list111(i,2);
        imname = [framesdir '/' vocabFile(ind,:)]; % add the full path
        im = imread(imname);
        grayim = rgb2gray(im);
        patch = getPatchFromSIFTParameters(vocabPos(ind,:), vocabSca(ind), vocabOri(ind),grayim);
        subplot(5,5,i);
        imshow(patch);
    end
    figure;
    for i = 1:25
        ind = list222(i,2);
        imname = [framesdir '/' vocabFile(ind,:)]; % add the full path
        im = imread(imname);
        grayim = rgb2gray(im);
        patch = getPatchFromSIFTParameters(vocabPos(ind,:), vocabSca(ind), vocabOri(ind),grayim);
        subplot(5,5,i);
        imshow(patch);
    end
end