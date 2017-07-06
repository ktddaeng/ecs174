function h = test(im1, im2, t1, t2)
    close all;
    tt1 = t1;
    tt2 = t2;
    %tt1 = [nomnom(t1(:,1), size(im1,1)) nomnom(t1(:,2), size(im1,2))];
    %tt2 = [nomnom(t2(:,1), size(im2,1)) nomnom(t2(:,2), size(im2,2))];
    h = computeH(tt1, tt2);
    disp(h);
    figure;
    imshow(im1);
    hold on;
    plot(t1(:,1), t1(:,2),'o','MarkerEdgeColor','k', 'MarkerFaceColor', 'r');
    
    to1 = [tt1'; ones(1,size(tt1,1))];
    to2 = h*to1;
    for i = 1:size(to2,2)
        to2(:,i) = to2(:,i)/to2(3,i);
    end
    to2(3,:) = [];
    tx2 = to2';
    %tx2 = [denomnom(tv2(:,1), size(im2,1)) denomnom(tv2(:,2), size(im2,2))];
    figure;
    
    to1 = [tt2';ones(1,size(tt2,1))];
    to2 = h\to1;
    for i = 1:size(to2,2)
        to2(:,i) = to2(:,i)/to2(3,i);
    end
    to2(3,:) = [];
    %tx2 = to2';
    %tx2 = [denomnom(tv2(:,1), size(im1,1)) denomnom(tv2(:,2), size(im1,2))];
    
    imshow(im2);
    hold on;
    plot(tx2(:,1), tx2(:,2),'o','MarkerEdgeColor','k', 'MarkerFaceColor', 'r');    
    
    figure;
    imshow(im2);
    hold on;
    plot(t2(:,1), t2(:,2),'o','MarkerEdgeColor','k', 'MarkerFaceColor', 'r');    
end

function n = nomnom(a, h)
    minA = 1;
    maxA = h;
    vN = (a - minA)/(maxA - minA);
    n = vN*2;
end

function n = denomnom(a, x)
    minA = 1;
    maxA = x;
    vO = a/2;
    n = vO*(maxA - minA) + minA;
end


function A = invCoor(in, out, h)
    tt2 = [nomnom(out(:,1), max(out(:,1))) nomnom(out(:,2), max(out(:,2)))];
    to1 = [tt2';ones(1,size(tt2,1))];
    to2 = h\to1;
    for i = 1:size(to2,2)
        to2(:,i) = to2(:,i)/to2(3,i);
    end
    to2(3,:) = [];
    tv2 = to2';
    A = [denomnom(tv2(:,1), max(in(:,1))) denomnom(tv2(:,2), max(in(:,2)))];
end