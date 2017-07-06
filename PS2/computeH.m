function H = computeH(t1, t2)
    if(size(t1,1) ~= size(t2,1))
        error('Number of points not equal!');
    end
    if((size(t1,1) < 4) || (size(t2, 1) < 4))
        error('Not enough corresponding points!');
    end
    A = zeros(2*size(t1,1), 9);
    for i = (1:size(t1,1))
       A((2*i - 1):(2*i),:) = [t1(i,1) t1(i,2) 1 0 0 0 -t2(i,1)*t1(i,1) -t2(i,1)*t1(i,2) -t2(i,1);
                               0 0 0 t1(i,1) t1(i,2) 1 -t2(i,2)*t1(i,1) -t2(i,2)*t1(i,2) -t2(i,2)]; 
    end
    %disp(A);
    %get eigenvector of A'*A with smallest eigenvalue
    %[V,D] = eig(A'*A);
    %s = sum(D,1);
    %disp(s);
    %[~, I] = min(s);
    %h = V(:,I);
    [h, ~] = eigs(A'*A, 1, 'sm');
    H = reshape(h,[3,3])';
end