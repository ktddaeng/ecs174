function [vocabDesc, vocabPos, vocabSca, vocabOri, vocabMember, vocabMeans, vocabFile] = buildVocab
    %establish paths
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    % Get a list of all the .mat files in that directory.
    % There is one .mat file per image.
    fnames = dir([siftdir '/*.mat']);

%fprintf('reading %d total files...\n', length(fnames));

    N = 50;  % to visualize a sparser set of the features
    vocabDesc = []; %vocab begins empty, will add descriptors
    vocabPos = [];
    vocabSca = [];
    vocabOri = [];
    vocabFile = [];

    % Loop through all the data files found, randomly fetch 100 descriptors
    for i=1:length(fnames)  %change back to all images, length(fnames)
        if (mod(i,20)~=0)
            continue;
        end
        
        fprintf('BV: reading frame %d of %d\n', i, length(fnames));
        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        numfeats = size(descriptors,1);
        if size(descriptors,1) == 0
            continue;
        end
        for j = 1:N
            vocabFile = cat(1,vocabFile,imname);
        end
        
        % get N random sample descriptors and put into SIFT space       
        randinds = randperm(numfeats);
        vocabDesc = cat(1,vocabDesc, descriptors(randinds(1:min([N,numfeats])),:));
        vocabPos = cat(1,vocabPos, positions(randinds(1:min([N,numfeats])),:));
        vocabSca = cat(1,vocabSca, scales(randinds(1:min([N,numfeats]))));
        vocabOri = cat(1,vocabOri, orients(randinds(1:min([N,numfeats]))));
    end
    %send to k means to quantize into 1500 words
    fprintf('BV: Calculating k-means...\n');
    [membership,means,rms] = kmeansML(1500,vocabDesc');
    vocabMember = membership;
    vocabMeans = means;
    %disp(size(membership)); %4800           1
    %disp(size(means));      %128        1500
    
    kMeans = vocabMeans';
    save('kMeans.mat', 'kMeans');
end