function winners = sortTopImages(list, names)
    [~, index] = sort(list, 'descend');
    winners = [];
    for i = 1:5
        n = names(index(i),:);
        winners = cat(1,winners,n);
    end
end