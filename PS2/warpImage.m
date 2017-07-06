function [warpIm, mergeIm] = warpImage(inputIm, refIm, h)
    close all;
    
    corners = [1 1; size(inputIm,1) 1 ; 1 size(inputIm,2); size(inputIm,1) size(inputIm,2)];
    
    %Use homography on the corners
    tt1 = corners;
    to1 = [tt1'; ones(1,size(tt1,1))];
    to2 = h*to1;
    for i = 1:size(to2,2)
        to2(:,i) = to2(:,i)/to2(3,i);
    end
    to2(3,:) = [];
    tv2 = to2';
    redN = tv2;
    redN = [redN; 1 1; size(refIm,1) 1 ; 1 size(refIm,2); size(refIm,1) size(refIm,2)];
    disp(redN);
    
    %Bounding Box
    [~,mxa] = max(redN(:,1)); %max x
    box = redN(mxa,1);
    [~,mxi] = min(redN(:,1)); %min x
    box = [box redN(mxi,1)];
    [~,mya] = max(redN(:,2)); %max y
    box = [box redN(mya,2)];
    [~,myi] = min(redN(:,2)); %min y
    box = [box redN(myi,2)];
    box = round(box(:));
    b = [box(3)-box(4) box(1)-box(2)];
    disp(box);
    disp(b);
    
    %inverse Warp
    [x,y] = meshgrid(box(2):(box(1)-1),box(4):(box(3)-1));
    bound = [x(:) y(:)];
    redInv = invCoor(bound, h);
    
    disp(size(redInv));
    
    rr = interp2(double(inputIm(:,:,1)),redInv(:,1), redInv(:,2),'linear',0);
    gg = interp2(double(inputIm(:,:,2)),redInv(:,1), redInv(:,2),'linear',0);
    bb = interp2(double(inputIm(:,:,3)),redInv(:,1), redInv(:,2),'linear',0);
    R = reshape(rr,b(1),b(2));
    G = reshape(gg,b(1),b(2));
    B = reshape(bb,b(1),b(2));
    ii = cat(3,R,G,B);
    disp(size(ii));
    figure;
    imshow(uint8(ii));
    
    warpIm = redInv;
    %warpIm = cat(3, redN, greenN, blueN);
    mergeIm = refIm;
    %mergeIm = inWarp(greenI, greenR, h);    
end

function A = invCoor(out, h)
    tt1 = out;
    to1 = [tt1'; ones(1,size(tt1,1))];
    to2 = h\to1;
    for i = 1:size(to2,2)
        to2(:,i) = to2(:,i)/to2(3,i);
    end
    to2(3,:) = [];
    tv2 = to2';
    A = tv2;
end