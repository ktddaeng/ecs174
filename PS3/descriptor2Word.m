function word = descriptor2Word(descriptor, vocabulary)    
    distances = dist2(descriptor, vocabulary);
    [~,I] = min(distances);
    word = I(1);
end