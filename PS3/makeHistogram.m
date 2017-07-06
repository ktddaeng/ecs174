function [bincounts, ind] = makeHistogram(image, vocab)
    %image = target image descriptors e.g. 2232*128
    %vocab = vocabulary descriptors 1500*128
    freq = zeros(size(image,1),1); %make sure means of vocab has been transposed
    
    distances = dist2(image,vocab); %2232*1500
    [~, freq] = min(distances,[],2); %gather visual word index of each descriptor

    %{
    for i = 1:size(image,1)
        distances = dist2(image(i,:),vocab);
        [~,indW] = min(distances);
        freq(i) = indW(1);
    end
    %}
    
    [bincounts, ind] = histc(freq, 1:1500);
    if (size(bincounts,1)==1)
        x = bincounts';
        bincounts = x;
    end
    %bincounts = the number of occurrences of each word
    %ind = the number bin/word that each descriptor belongs to
end