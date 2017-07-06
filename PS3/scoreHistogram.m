function score = scoreHistogram(source, test)
    %source = the histogram of reference image
    %test = the histogram to be scored against reference
    sBar = norm(source,'fro');
    tBar = norm(test,'fro');
    
    %score = the normalized scalar product,
    %higher score = a higher similarity
    score = (source*test')/(sBar * tBar);
end