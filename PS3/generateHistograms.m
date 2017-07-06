function generateHistograms    
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    %load kMeans from part 2
    fprintf('FQ: Loading kMeans...\n');
    load('kMeans1.mat');
    
    fnames = dir([siftdir '/*.mat']);
    histograms = [];
    sourceD = [];
    
    for i=1:length(fnames) 
        %load all images  
        
        fprintf('BV: reading frame %d of %d\n', i, length(fnames));
        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors');
        if (size(descriptors,1) > 0)
            %get histogram of each loaded image
            [histo,~] = makeHistogram(descriptors, kMeans);
        else
            histo = zeros(1500,1);
        end
        histograms = cat(1,histograms, histo');
        if (i == 1000)
            save('histograms.mat', 'histograms');
        end
    end
    %should be around 6612 x 1500
    %{
    save('histograms.mat', 'histograms');
    histograms = cat(1,histograms, histo');
    %}
    save('histograms.mat', 'histograms');
end